//
//  ViewableSystem.swift
//  TIMII
//
//  Created by Daddy on 5/12/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  
//  /Viewables/<userid>/+<componentid>/isViewable:BOOL
//
//  TODO: create function to store Viewables in cloud
//  TODO: change struct to protocol Viewable : Component - DONE - 5.12.18
//  TODO: move struct properties and methods to struct ViewableSystem - DONE - 5.12.18
//  TODO: add getter and setter - DONE
//  TODO: remove init and use getter and setter instead - DONE
//

import Foundation

struct ViewableSystem : Component, Viewable
{
    // MARK: -- Generic Properties --
    let ComponentDbName: String     = "Viewables"
    let ComponentName: String       = "viewable"
    var isViewable: Bool            = false
    
    // MARK: -- Properties --
    var dbName: String
    {
        get { return self.ComponentDbName }
    }
    
    var name: String
    {
        get { return self.ComponentName }
    }
        
    var view: Bool
    {
        // TODO: Add dbsystem function for getter and setter
        get { return self.isViewable }
        set(newIsViewable) { self.isViewable = newIsViewable }
    }
}
