//
//  DayComponent.swift
//  TIMII
//
//  Created by Dennis Huang on 9/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 9.16.18 [DONE] - Create Day component object that holds info on a day
 TODO: 9.11.18 - Create editable journal section for user
 TODO: 9.25.18 [DONE: 9.25.18] - Updated DayComponent class with updated Journal definition.
 */
 
import UIKit

class DayComponent: ComponentProtocol, ExpandableProtocol
{
    // Protocol Variables
    let ComponentName: String = "day"
    let ComponentDbName: String = "DayContainers"
    var isExpanded: Bool
    
    var journalPost: Journal
    var showTimer: Bool
    var thisDay: Date

    init(day: Date)
    {
        self.isExpanded = false
        self.journalPost = Journal( createdTimeStamp: Date(), post: "")
        self.showTimer = false
        self.thisDay = day
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
