//
//  TimerBox.swift
//  TIMII
//
//  Created by Dennis Huang on 7/24/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// TODO: 8.5.18 - Enable multi timer support for Text Field editting. Only one can be updated...
// TODO: 8.6.18 - DONE (8.6.18) Add suspend APP to & from background.
// TODO: 8.6.18 - DONE (8.7.18) Add save timer stats to cloud.
// TODO: 8.9.18 - DONE (8.9.18) Change saveTimers() this to save to Firestore
// TODO: 8.6.18 - Timer is slightly off as it resumes from background counting
// TODO: 8.7.18 - DEL (8.13.18) - Add Timer stats that overwrites or creates a new timer using Fanout
// TODO: 8.8.18 - Refactor timing functions into TimerSystem so it can be reused.
// TODO: 8.8.18 - DONE (8.13.18) Do not call write/read per updateView. only update pub/sub when starting, pausing or reseting timer
//                so write/reads to firebase are minimized for cost reasons. 100K concurrent before sharding...
// TODO: 8.8.18 - DONE (8.8.18) Research AWS / AppSync / GraphQL vs Firebase vs Cloud Firestore.
// TODO: 8.13.18 - DONE (8.13.18) Keyboard response slow?? Added keyboard Notification Observer. Seems faster now done.
// TODO: 8.13.18 - DONE (8.13.18) Refactored savetimers() function and moved this to DatabaseSystem.
// TODO: 8.13.18 - Read ongoing Timii tasks so accumulate time...Or just add to value before write...
// TODO: 8.14.18 - DONE (8.14.18) Fixed bug related to resume from background while timer is running

/* MARK:
 8.8.18
 What am I doing now? What is he/she doing now? Real-time life logger. Instead of a timer app. This is a RT-lifelogger app?!
 
 8.13.18
 Auto-track location + time: every 30 min FREE, 1 min $$
*/

import UIKit
import Layout

class TimerBox: UIViewController, LayoutLoading, UITextFieldDelegate
{
    
// MARK: ---------- CLASS PROPERTIES & INITIATIONS ----------
// Note: Outlet expressions must be set using a constant or literal value, and cannot
// be changed once set. Attempting to set the outlet using a state variable or other
// dynamic value will result in an error.
    
    @IBOutlet weak var timerNameTextField : UITextField!
    @IBAction func timerNameTextFieldTouchDown()
    {
        print("text box")
        guard let timerNameText = timerNameTextField.text, !timerNameText.isEmpty else { return }
    }
    
    var timerHour: String = "00"
    var timerMinute: String = "00"
    var timerSecond: String = "00"
    var counter: Double = 0
    var timerAccuracy = 0.1         // tenth of a second accuracy
    var tempTimer = Timer()             // what is this?
    var pauseTimerDate = Date()     // holds the timer value in case of suspend to background
    var isTimerRunning = false      // Timer is NOT running
    var isKeyboardVisible = false


    // 8.13.18 - Refactor and move database labels to 1 file so its consolidated and in 1 place
    let TIMER_NAME_KEY = "name"
    let TIMER_HOUR_KEY = "hour"
    let TIMER_MINUTE_KEY = "minute"
    let TIMER_SECOND_KEY = "second"
    let TIMER_RUNNING_KEY = "isTimerRunning"
    let TIMER_ID_KEY = "timerID"
    let ACCUMULATED_TIMER_KEY = "accumulatedTime"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Notification for when the Application moves to the Background or Foreground
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)

        // Notification for Keyboard / Text Field
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        self.loadLayout(
            named: "TimerBox.xml",
            state:[
                TIMER_NAME_KEY    : timerNameTextField?.text as Any,
                TIMER_MINUTE_KEY  : timerMinute,
                TIMER_SECOND_KEY  : timerSecond,
                TIMER_RUNNING_KEY : isTimerRunning
            ]
        )
    }
 
    
// MARK: ---------- TIMER FUNCTIONS ----------
// This section controls the timer like start / pause / reset
    
    @objc func startTimer()
    {
        // Start timer now
        print("Starting timer...")
        tempTimer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
 
    @objc func pauseTimer()
    {
        // Pause timer now
        print("Pausing timer...")
        tempTimer.invalidate()
        isTimerRunning = false
        updateView()
        saveTimers()
    }
    
    // TODO: 8.6.18 - Move this func to TimeCounterSystem.swift
    @objc private func updateTimer()
    {
        counter += 1
        timerHour      = TimeCounterSystem.timeHourString(counter)
        timerMinute    = TimeCounterSystem.timeMinuteString(counter)
        timerSecond    = TimeCounterSystem.timeSecondString(counter)
        updateView()
    }
    
    @objc private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            TIMER_NAME_KEY    : timerNameTextField?.text as Any,
            TIMER_MINUTE_KEY  : timerMinute,
            TIMER_SECOND_KEY  : timerSecond,
            TIMER_RUNNING_KEY : isTimerRunning
        ])
    }
    
    @objc func resetTimer()
    {
        tempTimer.invalidate()
        counter = 0
        timerHour      = TimeCounterSystem.timeHourString(counter)
        timerMinute    = TimeCounterSystem.timeMinuteString(counter)
        timerSecond    = TimeCounterSystem.timeSecondString(counter)
        updateView()
    }
    
    // Dismiss the keyboard after RETURN press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // The text field must resign its first-responder status when
        // the user taps a button like RETURN to end editing in the text field.
        if isTimerRunning == false { startTimer() }
        saveTimers()
        textField.resignFirstResponder()
        return true
    }
    
    
// MARK: ---------- START / PAUSE APP TO BACKGROUND ----------
// This section controls suspend functions when the APP goes to the background
    
    @objc private func willEnterForeground()
    {
        if isTimerRunning == true
        {
            let dateDifference = self.pauseTimerDate.timeIntervalSince(Date())
            counter -= dateDifference * 10      // time intervals in tenth of a second. timeIntervalSince returns negative
            startTimer()
            print("App moved to foreground! \(Date()) \(dateDifference) counter: \(counter)")
        }
        else
        {
            print("App moved to foreground without timer running.")
        }
        
    }
    
    @objc private func didEnterBackground()
    {
        self.pauseTimerDate = Date()
        tempTimer.invalidate()
//        isTimerRunning = false
        print("App moved to background! \(Date()) \(pauseTimerDate) counter: \(counter)")
        
        // Save Timer values to Firebase
        saveTimers()
    }
    
    
// MARK: ---------- SAVE TIMER VALUE TO DATABASE ----------
// This section handles the recording of timer values to Firebase
    
    private func saveTimers()
    {
        // Save to Firebase the timer values with FANOUT
        // 8.9.18 - Don't need FANOUT with Firestore given its not like Firebase?
        // Timers
        //      - UID
        //          - timerID
        //          - [values]
        //          - timeStamp
        //
        // Member-Timers
        //      - UID
        //          - timerIDs
        
        /* Timer Schema for Firestore
            Timers / UID
                timerID
                name
                hour + minute + second
                timeStamp
        */

        let componentRootName = "Timers"
        let timerID = UUID().uuidString
        let accumulatedTime = timerHour + timerMinute + timerSecond
        let timestamp = Date().timeIntervalSince1970
        let dataToSave: [String: Any] = [
            TIMER_ID_KEY          : timerID,
            TIMER_NAME_KEY        : timerNameTextField?.text as Any,
            ACCUMULATED_TIMER_KEY : accumulatedTime,
            "timestamp"           : timestamp
        ]
        let db = DatabaseSystem()
        db.addUserComponentDictFS(componentRootName, dataToSave)
    }

    // MARK: ---------- KEYBOARD FUNCTIONS ----------
    // This section controls keyboard Show or Hide functions
    
    @objc func keyboardWillShow(notification: Notification)
    {
        isKeyboardVisible = true
        updateView()
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        isKeyboardVisible = false
        updateView()
    }
}
