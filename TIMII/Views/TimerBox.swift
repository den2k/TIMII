//
//  TimerBox.swift
//  TIMII
//
//  Created by Dennis Huang on 7/24/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// TODO: 8.5.18 - Enable multi timer support for Text Field editting. Only one can be updated...
// TODO: 8.6.18 - Add suspend APP to & from background. DONE: 8.6
// TODO: 8.6.18 - Add save timer stats to cloud. DONE: 8.7
// TODO: 8.6.18 - Timer is slightly off as it resumes from background counting
// TODO: 8.7.18 - Add Timer stats that overwrites or creates a new timer using Fanout


import UIKit
import Layout
import Firebase     // Be nice to get rid of this import. Used for Auth..currentUser call

class TimerBox: UIViewController, LayoutLoading, UITextFieldDelegate
{
    
// MARK: ---------- CLASS PROPERTIES & INITIATIONS ----------
// Note: Outlet expressions must be set using a constant or literal value, and cannot
// be changed once set. Attempting to set the outlet using a state variable or other
// dynamic value will result in an error.
    
    @IBOutlet var timerNameTextField : UITextField?
    var timerHourLabel: String = "00"
    var timerMinuteLabel: String = "00"
    var timerSecondLabel: String = "00"
    var counter: Double = 0
    var timerAccuracy = 0.1         // tenth of a second accuracy
    var timer = Timer()             // what is this?
    var pauseTimerDate = Date()     // holds the timer value in case of suspend to background
    var isTimerRunning = false      // Timer is NOT running

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Notification for when the Application moves to the Background or Foreground
        NotificationCenter.default.addObserver(self, selector: #selector(pauseApp), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startApp), name: .UIApplicationWillEnterForeground, object: nil)

        self.loadLayout(
            named: "TimerBox.xml",
            state:[
                "name": timerNameTextField?.text as Any,
                "minute": timerMinuteLabel,
                "second": timerSecondLabel,
                "isTimerRunning": isTimerRunning
            ]
        )
    }
 
    
// MARK: ---------- TIMER FUNCTIONS ----------
// This section controls the timer like start / pause / reset
    
    @objc func startTimer()
    {
        if isTimerRunning == false
        {
            // Start timer now
            timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
        else
        {
            // Pause timer now
            timer.invalidate()
            isTimerRunning = false
            updateView()
            saveTimers()
        }
    }
    
    // TODO: 8.6.18 - Move this func to TimeCounterSystem.swift
    @objc private func updateTimer()
    {
        counter += 1
        timerHourLabel = TimeCounterSystem.timeHourString(counter)
        timerMinuteLabel = TimeCounterSystem.timeMinuteString(counter)
        timerSecondLabel = TimeCounterSystem.timeSecondString(counter)
        updateView()
    }
    
    @objc private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            "name": timerNameTextField?.text as Any,
            "minute": timerMinuteLabel,
            "second": timerSecondLabel,
            "isTimerRunning": isTimerRunning
        ])
    }
    
    @objc func resetTimer()
    {
        timer.invalidate()
        counter = 0
        timerHourLabel = TimeCounterSystem.timeHourString(counter)
        timerMinuteLabel = TimeCounterSystem.timeMinuteString(counter)
        timerSecondLabel = TimeCounterSystem.timeSecondString(counter)
        updateView()
    }
    
    // Dismiss the keyboard after RETURN press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // The text field must resign its first-responder status when
        // the user taps a button like RETURN to end editing in the text field.
        if isTimerRunning == false { startTimer() }
        textField.resignFirstResponder()
        return true
    }
    
    
// MARK: ---------- START / PAUSE APP TO BACKGROUND ----------
// This section controls suspend functions when the APP goes to the background
    
    @objc private func startApp()
    {
        let dateDifference = self.pauseTimerDate.timeIntervalSince(Date())
        counter -= dateDifference * 10      // time intervals in tenth of a second. timeIntervalSince returns negative
        startTimer()
        print("App moved to foreground! \(Date()) \(dateDifference) counter: \(counter)")
    }
    
    @objc private func pauseApp()
    {
        self.pauseTimerDate = Date()
        timer.invalidate()
        isTimerRunning = false
        print("App moved to background! \(Date()) \(pauseTimerDate) counter: \(counter)")
        
        // Save Timer values to Firebase
        saveTimers()
    }
    
    
// MARK: ---------- SAVE TIMER VALUE TO DATABASE ----------
// This section handles the recording of timer values to Firebase
    
    private func saveTimers()
    {
        // Save to Firebase the timer values with FANOUT
        // Timers
        //      - UID
        //          - timerID
        //          - [values]
        //          - timeStamp
        //
        // Member-Timers
        //      - UID
        //          - timerIDs
        
        let componentName1 = "Timers"
        let componentName2 = "Member-Timers"
        let timerID = UUID().uuidString
        guard let UID = Auth.auth().currentUser?.uid else { return }
        let dictionary = [
            "name": timerNameTextField?.text as Any,
            "hour": timerHourLabel,
            "minute": timerMinuteLabel,
            "second": timerSecondLabel
        ]
        let db1 = DatabaseSystem()
//        db1.addUserFanoutComponentId(componentName1, componentName2, timerID, UID)
        db1.addUserComponentCountableDict(componentName1, UID, dictionary)
    }
}
