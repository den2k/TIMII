//
//  Task.swift
//  TIMII
//
//  Created by Daddy on 7/21/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
import Foundation
 
struct Task
{
    // MARK: ----------- Properties -----------
    var taskName: String                // Holds the timer task name ie: Eating
    var taskStartDate: Date             // Holds the timer start time/date
    var timeAccrued: TimeInterval       // Holds the calculated accrued total run time for task
    
    // MARK: ---------- Initializers ----------
    init?(_ taskName: String,_ taskStartDate: Date,_ timeAccrued: TimeInterval)
    {
        // Task Name cannot be empty
        guard !taskName.isEmpty else { return nil }

        guard Double(timeAccrued) >= 0 else { return nil }
        
        // Initialize values
        self.taskName = taskName
        self.taskStartDate = taskStartDate
        self.timeAccrued = timeAccrued
    }
}
