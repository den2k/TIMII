//
//  MonthComponent.swift
//  TIMII
//
//  Created by Dennis Huang on 8/31/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import Foundation

struct MonthComponent : ComponentProtocol
{
    var ComponentDbName: String = "Months"
    var ComponentName: String = "month"
    
    var monthText = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
}
