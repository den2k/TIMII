//
//  TaskTimer.swift
//  T2
//
//  Created by Daddy on 1/11/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit        // includes Foundation
import os.log

 
class Task: NSObject, NSCoding {
    
    
    // MARK: ----------- Properties -----------
    
    var taskName: String
    var taskStartDate: Date
    var timeAccrued: TimeInterval
    
    
    // MARK: ---------- Archiving Paths ----------
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")
    
    
    // MARK: ---------- Types ----------
    
    struct PropertyKey {
        
        // These constants belong only to the struct and not the Task instance
        static let taskNameKey = "task name"
        static let taskStartDateKey = "task start date"
        static let timeAccruedKey = "time accrued"
        
    }
    
    
    // MARK: ---------- Initializers ----------
    
    init?(taskName: String, taskStartDate: Date, timeAccrued: TimeInterval) {
    
        // Task Name cannot be empty
        guard !taskName.isEmpty else {
            return nil
        }
        
        guard Double(timeAccrued) >= 0 else {
            return nil
        }
        
        // Initialize values
        self.taskName = taskName
        self.taskStartDate = taskStartDate
        self.timeAccrued = timeAccrued
        
    }
    
    // MARK: ---------- NSCoding ----------
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(taskName, forKey: PropertyKey.taskNameKey)
        aCoder.encode(taskStartDate, forKey: PropertyKey.taskStartDateKey)
        aCoder.encode(timeAccrued, forKey: PropertyKey.timeAccruedKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.taskNameKey) as? String else {
            os_log("Unable to decode the name for a Task object.", log: OSLog.default, type: .debug)
            return nil
        }
        let startDate = aDecoder.decodeObject(forKey: PropertyKey.taskStartDateKey) as! Date
        let accrued = aDecoder.decodeDouble(forKey: PropertyKey.timeAccruedKey)
     
        self.init(taskName: name, taskStartDate: startDate, timeAccrued: accrued)
        
    }

}
