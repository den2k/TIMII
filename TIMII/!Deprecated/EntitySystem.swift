//
//  EntitySystem.swift
//  TIMII
//
//  Created by Daddy on 5/10/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//

//  5.12.18
//  KILL doing the Entity in ECS
//      - 1. Implement protocol object programming
//      - 2. Separate properties into 'components' using protocols and methods into 'systems' using structs
//      - 3. Use firebase client fanout for storing data
//      - these 3 elements feel like it makes the E portion of the ECS architecture unnecessary

//import Foundation
//
//struct EntitySystem : Component
//{
//    var ComponentDbName: String     = "Entities"
//    var ComponentName: String       = "entity"
//    var ComponentId: UInt16         = 1
//    
//    var EntityUUID: String          = UUID().uuidString
//    var ComponentUUID: String       = UUID().uuidString
//    var Components                  = [Component]()
//}
//
//extension EntitySystem
//{
//    // mutating means you can modify the immutable properties within EntitySystem
//    mutating func addComponent(_ component: Component)
//    {
//        let c = component.ComponentName
//        print("Added " , c , " to: ", ComponentDbName)
//    }
//    
//    mutating func removeComponent(_ component: Component)
//    {
//        let c = component.ComponentName
//        print("Removed component: ", c)
//    }
//}
