//
//  TimerSecondCounter.swift
//  TIMII
//
//  Created by Daddy on 7/8/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit

class TimerSecondCounter : UIViewController
{
    @IBOutlet var timerSecondLabel: UILabel!
    // 7.21.18 - During initialization this variable is created. Not sure from where or why it is called.
    // But when the Start button is pressed, and this class is called. ViewDidLoad is reset?
    // and this UILabel goes nil.  It could be the combining of Layout and normal View Controllers?
    // I don't think so...hmmmm
    
    
//    var task = Task("Hi",Date(),0)              // Holds Task object
//    var timer = Timer()                         // Timer object
//    var timerAccuracy = 0.1                     // Assigns timer accuracy to tenth of a second
//    var isTimerRunning = false                  // Temporary BOOL for if timer is running
//    var counter: Double = 0                     // Temporary counter used by class
//
//    func startTimer()
//    {
//        // Start timer now
//        timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(TimerSecondCounter.updateTimer)), userInfo: nil, repeats: true)
//        isTimerRunning = true
//    }
//
//    func pauseTimer()
//    {
//        // Pause timer now
//        timer.invalidate()
//        isTimerRunning = false
//    }
//
//    @objc func updateTimer()
//    {
//        counter += 1
//        print("cnt",counter)
//        timerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
//    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        timerSecondLabel = UILabel()
        self.view.addSubview(timerSecondLabel)          // Must add views before constraints, before everything?
//        timerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
        timerSecondLabel.text = "33"
        timerSecondLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 35)
        timerSecondLabel.textColor = UIColor.white
        
        timerSecondLabel.translatesAutoresizingMaskIntoConstraints = false
        timerSecondLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timerSecondLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        timerSecondLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        timerSecondLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        
        // Set task variables to be passed to TaskTableViewController after the unwind segue.
//        let taskStartDate = Date()
//        let timeAccrued = counter
  //      self.task = Task(taskStartDate: taskStartDate, timeAccrued: timeAccrued)

        
    }
    

}
