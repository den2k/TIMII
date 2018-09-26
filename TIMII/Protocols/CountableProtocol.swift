//
//  CountableProtocol.swift
//  TIMII
//
//  Created by Daddy on 4/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  /Countables/<component name>/count: <number of records>
//
//  let count = Countables.increment(componentDbName)
//

import Foundation

protocol CountableProtocol
{
    func increment(_ countableComponentDbName : String)
}
