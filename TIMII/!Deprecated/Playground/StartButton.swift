////
////  StartButton.swift
////  TIMII
////
////  Created by Daddy on 7/7/18.
////  Copyright © 2018 Autonomii. All rights reserved.
////
//
//import UIKit
//import Layout
//
//class StartButton : UIViewController
//{
//    @IBOutlet var timerSecondLabel: UILabel!
//    /* 7.24.18 - this is wrong. How do I reference the timerSecondLabel created by the TimerSecondCouter VC? If I cannot pass this class to StartButton class it won't work. I need some way to either pass these classes between XML views or just don't bother and render the whole TimerBox in a VC.
//    */
//    
//    let tt = TimerSecondCounter()
//    var task = Timii("Hi",Date(),0)              // Holds Task object
//    var timer = Timer()                         // Timer object
//    var timerAccuracy = 0.1                     // Assigns timer accuracy to tenth of a second
//    var counter: Double = 0                     // Temporary counter used by class
//
//    
//    var isTimerRunning = false     // Timer not on - text : Start
//    {
//        didSet
//        {
//            startButton?.setState(["isToggled": isTimerRunning])
//        }
//    }
//    
//    @IBOutlet var startButton: LayoutNode?
//    {
//        didSet
//        {
//            startButton?.setState(["isToggled": isTimerRunning])
//        }
//    }
//    
//    @IBAction func startTimer()
//    {
//        self.isTimerRunning = true
//        // Start timer now
//        timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(StartButton.updateTimer)), userInfo: nil, repeats: true)
//
////        tt.startTimer()
//    }
//    @IBAction func pauseTimer()
//    {
//        self.isTimerRunning = false
////        tt.pauseTimer()
//    }
//    
//    @objc func updateTimer()
//    {
//        counter += 1
//        print("cnt",counter)
//        timerSecondLabel.text = TimeCounterSystem.timeSecondString(counter)
//    }
//}
//
