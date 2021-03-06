//
//  DateSystem.swift
//  TIMII
//
//  Created by Dennis Huang on 8/31/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 9.4.18 TODO: DONE 9.5.18 - Create getOffsetDayNumber() so the displayed date is not just +1 from indexPath
 */

import UIKit

struct DateSystem
{
    var monthText = [
        "JAN",
        "FEB",
        "MAR",
        "APR",
        "MAY",
        "JUN",
        "JUL",
        "AUG",
        "SEP",
        "OCT",
        "NOV",
        "DEC"
    ]

    var dayText = [
        "SUN",
        "MON",
        "TUE",
        "WED",
        "THU",
        "FRI",
        "SAT"
    ]

    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    let numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    let currentDayOfWeekIndex = Calendar.current.component(.weekday, from: Date())
    let todaysDate = Calendar.current.component(.day, from: Date())
    
    func getNumOfDaysInMonth(monthIndex: Int) -> Int
    {
        return numOfDaysInMonth[monthIndex]
    }

    func getOffsetDayNumber(index: Int) -> Int
    {
        // calculate the date number as the user scrolls through the calendar
        let offsetDate = Date().addingTimeInterval(Double(index) * 24.0 * 3600.0)
        
        // extract the date number from the offsetDate variable
        let offsetDayNumber = Calendar.current.component(.day, from: offsetDate)
        return offsetDayNumber
    }
    
    func getCurrentWeekDayText() -> String
    {
        let today = Calendar.current.component(.weekday, from: Date())    // SUN - SAT : 1 - 7
        return dayText[today - 1]
    }
    
    func getWeekDayText(index: Int) -> String
    {
        let today = Calendar.current.component(.weekday, from: Date())      // SUN - SAT : 1 - 7
        let i = (today + index - 1) % 7                                     // SUN - SAT : 0 - 6 to match array index
        return dayText[i]
    }
    
    func getWeekDayIndex(index: Int) -> Int
    {
        let today = Calendar.current.component(.weekday, from: Date())      // SUN - SAT : 1 - 7
        let i = (today + index - 1) % 7                                     // SUN - SAT : 0 - 6 to match array index
        return i
    }

    func getMonthText(index: Int) -> String
    {
        return monthText[index]
    }
    
    func getCurrentMonthText() -> String
    {
        return monthText[currentMonthIndex]
    }
    
    func isWeekend(dayOfWeekIndex: Int) -> Bool
    {
        if dayOfWeekIndex == 0 || dayOfWeekIndex == 6 {
            print("Weekend = Alright! \(dayOfWeekIndex)")
            return true
        } else {
            print("Weekday = Booo! \(dayOfWeekIndex)")
            return false
        }
    }

    // Returns all 7 days starting for the current day.  So if today is TUE, it returns TUE, WED, THU... MON
    func getWeekDayTextArray(index: Int) -> [String]
    {
        let today = Calendar.current.component(.weekday, from: Date())      // SUN - SAT : 1 - 7
        var dayTextArray: [String] = []
        var offSet: Int
        
        for x in 0...6
        {
            offSet = (today + index + x - 1 ) % 7
//            print(dayText[offSet])
            dayTextArray.append(dayText[offSet])
        }
        return dayTextArray
    }
}



