//
//  TimeCounterSystem.swift
//  T2
//
//  Created by Daddy on 2/10/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import Foundation

class TimeCounterSystem
{
    static func timeHourString(_ time: TimeInterval) -> String
    {
        let hours = Int(time) / 3600 % 600 / 10
        return String(format: "%02i", hours)
    }
    
    static func timeMinuteString(_ time: TimeInterval) -> String
    {
        let minutes = Int(time) / 60 % 600 / 10
        return String(format: "%02i", minutes)
    }
    
    static func timeSecondString(_ time: TimeInterval) -> String
    {
        let seconds = Int(time) % 600 / 10
        return String(format: "%02i", seconds)
    }
    
    static func timeTenthSecondString(_ time: TimeInterval) -> String
    {
        let tenthSeconds = Int(time) % 10
        return String(format: "%01i", tenthSeconds)
    }
}
