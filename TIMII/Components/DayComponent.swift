//
//  DayComponent.swift
//  TIMII
//
//  Created by Dennis Huang on 8/31/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import Foundation

struct DayComponent : ComponentProtocol
{
    var ComponentDbName: String = "Days"
    var ComponentName: String = "day"
    
    var dayText = [
        "SUN",
        "MON",
        "TUE",  
        "WED",
        "THU",
        "FRI",
        "SAT"
    ]
 
}
