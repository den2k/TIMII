//
//  DayContainerComponent.swift
//  TIMII
//
//  Created by Dennis Huang on 9/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 9.11.18 - Create editable journal section for user
 
 */
 
 
 
import UIKit

class DayContainerComponent: ComponentProtocol, ExpandableProtocol
{
    let ComponentDbName: String = "DayContainers"
    let ComponentName: String = "day"
    var isExpanded: Bool = false
    var journalText: String
    
    init()
    {
        journalText = "Type something. Now!"
    }
}
