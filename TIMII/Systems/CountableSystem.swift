//
//  CountableSystem.swift
//  TIMII
//
//  Created by Daddy on 5/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct CountableSystem : ComponentProtocol, CountableProtocol
{
    // MARK: -- Component Properties --
    let ComponentDbName: String     = "Countables"
    let ComponentName: String       = "countable"
    
    let REF = Database.database().reference()
    
    func incrementComponentCount(_ countableComponentDbName: String)
    {
        //  TODO: increments Countable. - DONE - 5.17.18
        //  /Countables/<component name>:<number of records>
        //  let count = Countables.incrementComponentCount(componentDbName)
        //  8.7.18  - DEPRECATED. Closures seems to prevent calls like this from working
        //            so increment is done inside database call and does not use this function
        
        
        let REFChild = REF.child("\(ComponentDbName)/")
        
        REFChild.runTransactionBlock
        {
            (currentData: MutableData) -> TransactionResult in
            if var data = currentData.value as? [String: Any]
            {
                var count = data["\(countableComponentDbName)"] as? UInt64 ?? 0
                print("cnt:",count)
                count += 1
                data["\(countableComponentDbName)"] = count
                currentData.value = data
            }
            return TransactionResult.success(withValue: currentData)
        }
    }
    

    // MARK: -- DEPRECATED --
    
    func increment(_ countableComponentDbName: String)
    {
        //  TODO: Deprecated by incrementComponentCount - 5.17.18
        //  TODO: increments Countable. - DONE - 5.12.18
        //  /Countables/<component name>/count: <number of records>
        //  let count = Countables.increment(componentDbName)
        
        let REFChild = REF.child("\(ComponentDbName)/\(countableComponentDbName)/")
        
        REFChild.runTransactionBlock
            {
                (currentData: MutableData) -> TransactionResult in
                if var data = currentData.value as? [String: Any]
                {
                    var count = data["count"] as? UInt64 ?? 0
                    count += 1
                    data["count"] = count
                    currentData.value = data
                }
                return TransactionResult.success(withValue: currentData)
        }
    }

}
