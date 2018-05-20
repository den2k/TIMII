//
//  ComponentSystem.swift
//  TIMII
//
//  Created by Daddy on 5/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  TODO: extension fetchByComponentId
//  TODO: add getters - DONE

import Foundation

struct ComponentSystem : Component
{
    // MARK: -- Protocol --
    let ComponentDbName: String     = "Components"
    let ComponentName: String       = "component"
    
    var dbName: String
    {
        get { return self.ComponentDbName }
    }
    
    var name: String
    {
        get { return self.ComponentName }
    }
}
