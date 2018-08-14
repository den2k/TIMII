////
////  TimerViewController.swift
////  T2
////
////  Created by Daddy on 12/27/17.
////  Copyright © 2017 Autonomii. All rights reserved.
////
//
//import UIKit
//import os.log
//
//class TimerViewController: UIViewController {
//
//    
//    // MARK: ---------- Properties and Outlets ----------
//    
//    @IBOutlet var taskNameTextField: UITextField!
//    @IBOutlet var taskTimerHourLabel: UILabel!
//    @IBOutlet var taskTimerMinuteLabel: UILabel!
//    @IBOutlet var taskTimerSecondLabel: UILabel!
//    @IBOutlet var startButton: UIButton!
//    @IBOutlet var resetButton: UIButton!
//    @IBOutlet var saveButton: UIBarButtonItem!
//    
//    /*
//     This value is either passed by `TaskTableViewController` in `prepare(for:sender:)`
//     or constructed as part of adding a new meal.
//     */
//    var task: Timii?
//    
//    
//    // MARK: ---------- Timer Related ----------
//    // This section controls the timer like start / pause / reset
//
//    var counter: Double = 0
//    var timerAccuracy = 0.1   // tenth of a second accuracy
//    var timer = Timer()
//    var pauseTimerDate = Date()
//    var isTimerRunning = false
//    
//    @IBAction func startTimerTapped(_ sender: UIButton) {
//        
//        if isTimerRunning == false {
//            startTimer()
//        } else {
//            pauseTimer()
//        }
//        
//    }
//    
//    @IBAction func resetTimerTapped(_ sender: UIButton) {
//        
//        timer.invalidate()
//        counter = 0
//        taskTimerHourLabel.text = TimeCounterSystem.timeHourString(counter)
//        taskTimerMinuteLabel.text = TimeCounterSystem.timeMinuteString(counter)
//        taskTimerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
//        
//    }
//    
//    private func startTimer() {
//
//        // Start timer now
//        timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
//        isTimerRunning = true
//        startButton.setTitle("Pause", for: .normal)
//        startButton.backgroundColor = UIColor.red
//        resetButton.isHidden = true
//        
//    }
//
//    private func pauseTimer() {
//
//        // Pause timer now
//        timer.invalidate()
//        isTimerRunning = false
//        startButton.setTitle("Go", for: .normal)
//        startButton.backgroundColor = UIColor.green
//        resetButton.isHidden = false
//        
//    }
//    
//    @objc func updateTimer() {
//        
//        counter += 1
//        taskTimerHourLabel.text = TimeCounterSystem.timeHourString(counter)
//        taskTimerMinuteLabel.text = TimeCounterSystem.timeMinuteString(counter)
//        taskTimerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
//        
//    }
//    
//    @objc private func pauseApp() {
//        
//        timer.invalidate()
//        self.pauseTimerDate = Date()
//        print("App moved to background! \(Date()) \(pauseTimerDate) counter: \(counter)")
//        
//    }
//    
//    
//    @objc private func startApp() {
//        
//        let dateDifference = self.pauseTimerDate.timeIntervalSince(Date())
//        counter -= dateDifference * 10      // time intervals in tenth of a second. timeIntervalSince returns negative
//        startTimer()
//        print("App moved to foreground! \(Date()) \(dateDifference) counter: \(counter)")
//        
//    }
//    
//    
//    // MARK: ---------- Navigation Related ----------
//    
//    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
//        
//        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
//        let isPresentingInAddMealMode = presentingViewController is UINavigationController
//        
//        if isPresentingInAddMealMode {
//            
//            dismiss(animated: true, completion: nil)
//            
//        } else if let owningNavigationController = navigationController {
//            
//            owningNavigationController.popViewController(animated: true)
//            
//        } else {
//            
//            fatalError("The TimerViewController is not inside a navigation controller.")
//            
//        }
//
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        super.prepare(for: segue, sender: sender)
//        
//        guard let button = sender as? UIBarButtonItem, button === saveButton else {
//            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//            return
//        }
//        
//        // Set task variables to be passed to TaskTableViewController after the unwind segue.
//        let taskName = self.taskNameTextField.text ?? ""
//        let taskStartDate = Date()
//        let timeAccrued = counter
//        self.task = Task(taskName, taskStartDate, timeAccrued)
//        
//    }
//    
//    private func updateSaveButtonState() {
//        
//        // Disable the Save button if the text field is empty.
//        let text = taskNameTextField.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
//        
//    }
//
//
//    // MARK: ---------- Class Instance Related ----------
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        // Notification for when Application moved to Background or Foreground
//        NotificationCenter.default.addObserver(self, selector: #selector(pauseApp), name: .UIApplicationDidEnterBackground, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(startApp), name: .UIApplicationWillEnterForeground, object: nil)
//
//        // Look and Feel
//        startButton.layer.cornerRadius = 8
//        startButton.backgroundColor = UIColor.green
//        resetButton.layer.cornerRadius = 8
//        taskNameTextField.textColor = .white
//        taskNameTextField.backgroundColor = .black
//        taskNameTextField.attributedPlaceholder = NSAttributedString(string: "enter task", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
//        resetButton.isHidden = true
//        
//        // Handle the text field's inputs through a delegate callback within
//        // this View Controller
//        taskNameTextField.delegate = self
//
//        // Set up views if editing an existing Task.
//        if let task =  self.task {
//            
//    //        navigationItem.title = task.taskName
//  //          taskNameTextField.text = task.taskName
//            counter = task.timeAccrued
//            taskTimerHourLabel.text = TimeCounterSystem.timeHourString(counter)
//            taskTimerMinuteLabel.text = TimeCounterSystem.timeMinuteString(counter)
//            taskTimerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
//            
//        }
//        
//        // Enable the Save button only if the text field has a valid Meal name.
//        updateSaveButtonState()
//        
//    }
//
// 
//    
//    
//}
//
//
//extension TimerViewController: UITextFieldDelegate {
//    
//    // This section is related to the task label - text field manipulation, etc.
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // The text field must resign its first-responder status when
//        // the user taps a button like RETURN to end editing in the text field.
//        if isTimerRunning == false {
//            startTimer()
//        }
//        
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Disable the Save button while editing.
//        saveButton.isEnabled = false
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateSaveButtonState()
//        navigationItem.title = textField.text
//    }
//
//    
//    
//}
