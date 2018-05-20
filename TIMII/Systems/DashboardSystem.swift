//
//  DashboardSystem.swift
//  TIMII
//
//  Created by Daddy on 5/12/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  TODO: Added UIStyle protocol to Dashboards - DONE - 5.19.18

import Foundation

struct DashboardSystem : Component, Dashboard, Viewable, UIStyle
{
    // MARK: -- Properties --
    var ComponentDbName: String     = "Dashboards"
    var ComponentName: String       = "dashboard"
    
    // Dashboards are viewable and Full screen by default
    var isViewable: Bool            = true
    var UIType: String              = UIStyleSystem.FullScreen.getUITypeTextLabel()
    
    
    // MARK: -- Methods --
    init(_ user : String)
    {
        // TODO: /Dashboards/<userid>/<dashboardcountableid>:home - DONE - 5.19.18
        
        let database = DatabaseSystem()
        database.addUserComponentUpdateCountable(ComponentDbName, user, "home")

        // DEPRECATED : /Dashboards/<userid>/<dashboardid>:home - DONE - 5.12.18
        // Add 1 to Dashboard count record
        // let cid = UUID().uuidString
        // database.addUserComponentIdValue(ComponentDbName, user, cid, "home")
        // CountableSystem().incrementComponentCount(ComponentDbName)
    }
    
    func addDashboard(_ user : String, _ dashboardName : String)
    {
        
        // TODO: /Dashboards/<userid>/<dashboardcountableid>:dashboardName - DONE - 5.19.18

        let database = DatabaseSystem()
        database.addUserComponentUpdateCountable(ComponentDbName, user, dashboardName)

        // DEPRECATED : /Dashboards/<userid>/<dashboardid>:dashboardName - DONE - 5.12.18
        // Add 1 to Dashboard count record
        // let cid = UUID().uuidString
        // database.addUserComponentIdValue(ComponentDbName, user, cid, dashboardName)
        // CountableSystem().incrementComponentCount(ComponentDbName)
    }

}
