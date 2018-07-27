//
//  ComponentSystemTests.swift
//  TIMIITests
//
//  Created by Daddy on 5/9/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import XCTest

@testable import TIMII

class ComponentSystemTests: XCTestCase
{
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testGetComponentDbName()
    {
        // TODO: move this to viewabletests
        let cs = ComponentSystem()
        let expected = "Components"
        let results = cs.ComponentDbName
        XCTAssert(results == expected)
    }
    
    func testAddComponent()
    {
        
    }
}

