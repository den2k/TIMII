//
//  ViewableTests.swift
//  TIMIITests
//
//  Created by Daddy on 5/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import XCTest

@testable import TIMII

class ViewableTests: XCTestCase
{
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testSetIsViewable()
    {
        var testViewable = ViewableSystem()
        testViewable.isViewable = true
        XCTAssert(testViewable.isViewable)
    }
    
    func testGetIsViewable()
    {   // default isViewable is false
        let v = ViewableSystem()
        let results = v.isViewable
        let expected = false
        XCTAssert(results == expected)
    }

    func testGetComponentDbName()
    {
        // TODO: move this to viewabletests
        let v = ViewableSystem()
        let expected = "Viewables"
        let results = v.ComponentDbName
        XCTAssert(results == expected)
    }
}
