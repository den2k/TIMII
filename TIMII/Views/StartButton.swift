//
//  StartButton.swift
//  TIMII
//
//  Created by Daddy on 7/7/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Layout

class StartButton : UIViewController
{
    var isTimerRunning = false     // Timer not on - text : Start
    {
        didSet
        {
            startButton?.setState(["isToggled": isTimerRunning])
        }
    }
    
    @IBOutlet var startButton: LayoutNode?
    {
        didSet
        {
            startButton?.setState(["isToggled": isTimerRunning])
        }
    }
    
    @IBAction func startTimer()
    {
        self.isTimerRunning = true
    }
    @IBAction func pauseTimer()
    {
        self.isTimerRunning = false
    }
}

