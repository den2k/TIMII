//
//  DayComponent.swift
//  TIMII
//
//  Created by Dennis Huang on 9/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 9.16.18 - Create Day component object that holds info on a day
 TODO: 9.11.18 - Create editable journal section for user
 
 */
 
import UIKit

class DayComponent: ComponentProtocol, ExpandableProtocol, JournalProtocol, TimeStampProtocol
{
    // Protocol Variables
    let ComponentName: String = "day"
    let ComponentDbName: String = "DayContainers"
    internal var createdTimeStamp: Date
    var isExpanded: Bool
    var journalText: UITextView?

    var showTimer: Bool
    var thisDay: Date

    init(day: Date)
    {
        self.thisDay = day
        createdTimeStamp = Date()
        isExpanded = false
        journalText?.text = "Type something. Now!"
        showTimer = false
    }
    
    func getDayText(index: Int) -> String
    {
        return DateSystem().getWeekDayText(index: index)
    }
    
    func getDayNumberText(index: Int) -> Int
    {
        return DateSystem().getOffsetDayNumber(index: index)
    }
        
}
