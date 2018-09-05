//
//  DateSystem.swift
//  TIMII
//
//  Created by Dennis Huang on 8/31/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 9.4.18 TODO: Create getDayOfMonth() so the displayed date is not just +1 from indexPath
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

    let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    let currentYear = Calendar.current.component(.year, from: Date())
    let todaysDate = Calendar.current.component(.day, from: Date())
    let currentDayOfWeekIndex = Calendar.current.component(.weekday, from: Date())
    
    let numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    

    func getCurrentWeekDayText() -> String
    {
        let today = Calendar.current.component(.weekday, from: Date())    // SUN - SAT : 1 - 7
        return dayText[today - 1]
    }
    
    func getWeekDayText(index: Int) -> String
    {
        let today = Calendar.current.component(.weekday, from: Date())    // SUN - SAT : 1 - 7
        let i = (today + index - 1) % 7
        return dayText[i]
    }
    
    func getWeekDayIndex(index: Int) -> Int
    {
        let today = Calendar.current.component(.weekday, from: Date())    // SUN - SAT : 1 - 7
        let i = (today + index - 1) % 7
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

}



