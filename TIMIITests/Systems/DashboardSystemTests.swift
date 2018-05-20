//
//  DashboardSystemTests.swift
//  TIMIITests
//
//  Created by Daddy on 5/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import XCTest

@testable import TIMII

class DashboardSystemTests: XCTestCase {
    
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }

    func testAddDashboard()
    {
        // Tested 5.15.18.
        let uid1 = UUID().uuidString
        let board1 = DashboardSystem(uid1)
        board1.addDashboard(uid1, "2nd Dashboard")
        board1.addDashboard(uid1, "3nd Dashboard")
    }
    
}
