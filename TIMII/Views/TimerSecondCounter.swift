//  Created by Daddy on 7/8/18.
//  Copyright © 2018 Autonomii. All rights reserved.

import UIKit

class TimerSecondCounter : UIViewController
{
    @IBOutlet var timerSecondLabel: UILabel!
    var counter: Double = 0
    var timerAccuracy = 0.1   // tenth of a second accuracy
    var timer = Timer()
    var isTimerRunning = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        timerSecondLabel = UILabel()
        timerSecondLabel.text = TimeCounterSystem.timeSecondString(time: counter)
        timerSecondLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 35)
        timerSecondLabel.textColor = UIColor.white
        self.view.addSubview(timerSecondLabel)
        
        timerSecondLabel.translatesAutoresizingMaskIntoConstraints = false
        timerSecondLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timerSecondLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        timerSecondLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        timerSecondLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    @IBAction func startTimerTapped(_ sender: UIButton)
    {
        if isTimerRunning == false {
            startTimer()
        } else {
            pauseTimer()
        }
    }
        
    @objc func updateTimer()
    {
        counter += 1
        timerSecondLabel.text = TimeCounterSystem.timeSecondString(time: counter)
    }

    private func startTimer()
    {
        // Start timer now
        timer = Timer.scheduledTimer(timeInterval: timerAccuracy, target: self, selector: (#selector(TimerSecondCounter.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    private func pauseTimer()
    {
        // Pause timer now
        timer.invalidate()
        isTimerRunning = false
    }
    
}
