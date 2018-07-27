//
//  SetupSystem.swift
//  TIMII
//
//  Created by Daddy on 5/13/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
//  TODO: GlobalServiceSetup - DONE - 5.13.18
//  TODO: GlobalServiceNewComponentSetup - DONE - 5.13.18
//  TODO: CountableSetup - DONE - 5.13.18
//

import Foundation
import FirebaseDatabase

struct SetupSystem
{
    let REF = Database.database().reference()   // Firebase Database Reference locator

    func GlobalServiceSetup()
    {
        CountableSetup("Dashboards")
        CountableSetup("Tasks")
        CountableSetup("Timers")
        CountableSetup("Viewables")
        CountableSetup("UIStyleables")
    }

    func GlobalServiceNewComponentSetup(_ componentDbName: String)
    {
        CountableSetup(componentDbName)
    }
    
    private func CountableSetup(_ componentDbName: String)
    {
        // Countable is a special Global Variable and not tied to a user.
        // Creates Counter for a component for first time for the global service
        // But this causes it to reset this value each time you run the App.
        // Probably just easier to not use code but manually create the global service
        // variables.
        
        // TODO: changed from setValue to updateChildValues to prevent full REFchild overwrite
        // TODO: initialize Countable Node in Firebase - DONE - 5.12.18
        let REFChild = REF.child("Countables")
        
        REFChild.runTransactionBlock
        {
            (currentData: MutableData) -> TransactionResult in
            REFChild.updateChildValues(["\(componentDbName)": 0])
            return TransactionResult.success(withValue: currentData)
        }
    }
}
