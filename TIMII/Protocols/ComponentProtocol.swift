//
//  ComponentProtocol.swift
//  TIMII
//
//  Created by Daddy on 5/5/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  Notes:
//  UInt16 - 0 to 65,535
//  UInt32 - 0 to 4,294,967,295
//  UInt64 - 0 to 18,446,744,073,709,551,615
//  UUID   - 0 to 5,316,911,983,139,663,491,615,228,241,121,400,000


import Foundation

protocol ComponentProtocol
{
    var ComponentDbName: String { get }         // the root node name used in Firebase
    var ComponentName: String { get }           // component name for convinence
}
