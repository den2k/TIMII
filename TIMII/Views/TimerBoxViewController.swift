//
//  TimerBoxViewController.swift
//  TIMII
//
//  Created by Dennis Huang on 7/24/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Layout

class TimerBoxViewController: UIViewController, LayoutLoading
{
    // MARK: ---------- Properties and Outlets ----------
    // Outlet Expressions cannot be changed and are static. To have a dynamic changing
    // expression / variable - we cannot use Outlets.
    // Note: Outlet expressions must be set using a constant or literal value, and cannot
    // be changed once set. Attempting to set the outlet using a state variable or other
    // dynamic value will result in an error.
    
    // MARK: ---------- Class Properties ----------
    var taskTimerNameLabel: String = "Eating"
    var taskTimerHourLabel: String = "00"
    var taskTimerMinuteLabel: String = "00"
    var taskTimerSecondLabel: String = "00"
    var counter: Double = 0
    var timerAccuracy = 0.1   // tenth of a second accuracy
    var timer = Timer()
    var pauseTimerDate = Date()
    var isTimerRunning = false      // Timer is NOT running

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadLayout(
            named: "TimerBoxViewController.xml",
            state:[
                "name": taskTimerNameLabel,
                "minute": taskTimerMinuteLabel,
                "second": taskTimerSecondLabel,
                "isTimerRunning": isTimerRunning
            ]
        )
    }
 
    // MARK: ---------- Timer Related Functions ----------
    // This section controls the timer like start / pause / reset
    
    @objc func startTimer()
    {
        if isTimerRunning == false
        {
            // Start timer now
            timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
        else
        {
            // Pause timer now
            timer.invalidate()
            isTimerRunning = false
            updateView()
        }
    }
    
    @objc private func updateTimer()
    {
        counter += 1
        taskTimerHourLabel = TimeCounterSystem.timeHourString(counter)
        taskTimerMinuteLabel = TimeCounterSystem.timeMinuteString(counter)
        taskTimerSecondLabel = TimeCounterSystem.timeSecondString(counter)
        updateView()
    }
    
    @objc private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            "name": taskTimerNameLabel,
            "minute": taskTimerMinuteLabel,
            "second": taskTimerSecondLabel,
            "isTimerRunning": isTimerRunning
        ])
    }
    
    @objc func resetTimerTapped()
    {
        timer.invalidate()
        counter = 0
        taskTimerHourLabel = TimeCounterSystem.timeHourString(counter)
        taskTimerMinuteLabel = TimeCounterSystem.timeMinuteString(counter)
        taskTimerSecondLabel = TimeCounterSystem.timeSecondString(counter)
    }
    
    @objc private func startApp()
    {
        let dateDifference = self.pauseTimerDate.timeIntervalSince(Date())
        counter -= dateDifference * 10      // time intervals in tenth of a second. timeIntervalSince returns negative
        startTimer()
        print("App moved to foreground! \(Date()) \(dateDifference) counter: \(counter)")
    }
    
    @objc private func pauseApp()
    {
        timer.invalidate()
        self.pauseTimerDate = Date()
        print("App moved to background! \(Date()) \(pauseTimerDate) counter: \(counter)")
    }
}


extension TimerBoxViewController: UITextFieldDelegate
{
    // This section is related to the task label - text field manipulation, etc.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // The text field must resign its first-responder status when
        // the user taps a button like RETURN to end editing in the text field.
        if isTimerRunning == false { startTimer() }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Disable the Save button while editing.
//        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
//        updateSaveButtonState()
        navigationItem.title = textField.text
    }
}
