//
//  DatabaseSystemTests.swift
//  TIMIITests
//
//  Created by Daddy on 5/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import XCTest

@testable import TIMII

class DatabaseSystemTests: XCTestCase
{
    func testDatabaseSystemAddDictionary()
    {
        // TODO: fix this so it can be unit tested.
        let rootName = "XCTests"
        let dict = ["key1": true,
                    "key2": "value2"] as [String : Any]
        let dd = DatabaseSystem()
        dd.addDictionary(rootName, dict)
    }

    func testDatabaseSystemAddNestedDictionary()
    {
        // Tested 5.2018
        // TODO: fix this so it can be unit tested.
        let rootName = "XCTests"
        let childName = "xctest"
        let dict = ["key1": true,
                    "key2": "value2"] as [String : Any]
        let dd = DatabaseSystem()
        dd.addNestedDictionary(rootName, childName, dict)
    }
    
    func testDatabaseSystemAddUserComponentId()
    {
        // Tested 5.2018
        // /Tasks/<userid>/+<taskid>
        let rootName = "Tasks"
        let uuid = UUID().uuidString
        let componentId = UUID().uuidString
        let dd2 = DatabaseSystem()
        dd2.addUserComponentId(rootName, uuid, componentId)
    }
    
    func testDatabaseSystemAddUserFanoutComponentId()
    {
        // Tested 5.2018
        // /Tasks/<userid>/+<taskid>
        // /Feeds/<userid>/+<taskid>
        let rootName1 = "Tasks"
        let rootName2 = "Feeds"
        let uuid2 = UUID().uuidString
        let tasksId = UUID().uuidString
        let dd3 = DatabaseSystem()
        dd3.addUserFanoutComponentId(rootName1, rootName2, uuid2, tasksId)
    }
}

