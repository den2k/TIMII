//
//  Timii.swift
//  TIMII
//
//  Created by Daddy on 7/21/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
import Foundation
 
struct Timii
{
    // MARK: ----------- Properties -----------
    var timiiName: String               // Holds the timer name ie: Eating
    var taskStartDate: Date             // Holds the timer start time/date
    var timeAccrued: TimeInterval       // Holds the calculated accrued total run time for task
    
    // MARK: ---------- Initializers ----------
    init?(_ name: String,_ date: Date,_ time: TimeInterval)
    {
        // Timii Name cannot be empty
        guard !name.isEmpty else { return nil }
        guard Double(time) >= 0 else { return nil }
        
        // Initialize values
        self.timiiName = name
        self.taskStartDate = date
        self.timeAccrued = time
    }
}
