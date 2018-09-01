//
//  Member.swift
//  TIMII
//
//  Created by Dennis Huang on 8/2/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit

class Member: NSObject, ComponentProtocol
{
    var ComponentDbName: String = "Members"
    var ComponentName: String = "member"
    
    var uid: String?
    var name: String?
    var email: String?
    var password: String?
    var profileImageURL: String?
}
