//
//  DatabaseSystem.swift
//  TIMII
//
//  Created by Daddy on 5/6/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// TODO: 8.7.18 - Add new Fanout function with Countable

import Foundation
import Firebase
//import FirebaseDatabase

struct DatabaseSystem
{
    let REF = Database.database().reference()   // Firebase Database Reference locator
    
    func addDictionary(_ componentDbName: String, _ dictionary: Dictionary<String,Any>)
    {
        //  TODO: rename method to something more accurate - DONE - 5.12.18
        //  TODO: create addDictionary - DONE - 5.11.18
        //
        //  /ComponentDbName/$UID/dictionary
        //
    
        let uid = UUID().uuidString
        let childUpdates = ["/\(componentDbName)/\(uid)" : dictionary]
        REF.updateChildValues(childUpdates)
        print("DBSystem:addDictionary:", childUpdates)
    }
    
    func addNestedDictionary(_ componentDbName1: String, _ componentDbName2: String, _ dictionary: Dictionary<String,Any>)
    {
        //  TODO: rename method to something more accurate - DONE - 5.12.18
        //  TODO: create addNestedDictionary - DONE - 5.12.18
        //
        //  /ComponentDbName1-ComponentDbName2/$uid1/$uid2/dictionary
        
        let uid1 = UUID().uuidString
        let uid2 = UUID().uuidString
        let childUpdates = ["/\(componentDbName1)-\(componentDbName2)/\(uid1)/\(uid2)" : dictionary]
        REF.updateChildValues(childUpdates)
        print("DBSystem:addNestedDictionary:", childUpdates)
    }

    func addUserComponentId(_ componentDbName: String, _ user: String, _ componentId: String)
    {
        //  TODO: implement - DONE - 5.12.18
        //
        //  /Tasks/<userid>/+<taskid>
        //  /Timers/<userid>/+<timerid>
        //  /Followers/<userid>/+<followeruserid>
        //  /Feeds/<userid>/+<taskid>
        //                 /+<todoid>
        //                 /+<eventid>
        //                 /+<timerid>
        //  /Viewables/<userid>/+<componentid>
        //  /Dashboards/<userid>/+<panelid>
        //  /Panels/<userid>:<panelid>/+<componentid>
        
        let childUpdates = ["/\(componentDbName)/\(user)/" : componentId]
        REF.updateChildValues(childUpdates)
        print("DatabaseSystem:addUserComponentId:", childUpdates)
    }
    
    func addUserFanoutComponentId(_ componentDbName1: String, _ componentDbName2: String, _ user: String, _ componentId: String)
    {
        //  TODO: implement - DONE - 5.12.18
        //
        //  /<componentDbName1>/<userid>/+<taskid>
        //  /<componentDbName2>/<userid>/+<taskid>
        
        let childUpdates = ["/\(componentDbName1)/\(user)/" : componentId ,
                            "/\(componentDbName2)/\(user)/" : componentId]
        REF.updateChildValues(childUpdates)
        print("DatabaseSystem:addUserFanoutComponentId:", childUpdates)
    }

    func addUserComponentIdValue(_ componentDbName: String, _ user: String, _ componentId: String, _ value: Any)
    {
        //  /<componentDbName>/<userid>/<componentid>:value

        let childUpdates = ["/\(componentDbName)/\(user)/\(componentId)" : value]
        REF.updateChildValues(childUpdates)
        print("DatabaseSystem:addUserComponentId:", childUpdates)
    }
    
    func addUserComponentCountableDict(_ componentDbName: String, _ user: String, _ value: Any)
    {
        //  /<componentDbName>/<userid>/<componentid>:value
        //  TODO: generate component id using generated values. Does not use UUID. - DONE - 5.19.18
        //  cannot read countables value as async nature prevents
        //  timely reads and so I can generate my own values by first
        //  reading countable count and then iterative with a local
        //  counter to right sequency values for each component
        
        let REFChild = REF.child("Countables")
             
        REFChild.runTransactionBlock
        {
            (currentData: MutableData) -> TransactionResult in
            if var data = currentData.value as? [String: Any]
            {
                var count = data["\(componentDbName)"] as? UInt64 ?? 0

                // This looks to eliminate the need for Countable to set any values.
                // Because of the atomic nature of setting and reading values
                // an updates that need to go to multiple places
                // must be done in the same DB closure calls like this one.
                // So I will comment out the Countable calls to increment
                // and deprecate incrementComponentCount
                
                // Increment Component Count in Countable
                count += 1
                data["\(componentDbName)"] = count
                currentData.value = data        // Update Countable

                // Update count value
                //  /<componentDbName>/<userid>/count:value

                let childUpdates = ["/\(componentDbName)/\(user)/\(count)": value]
                self.REF.updateChildValues(childUpdates)        // Add User Component Value

            }
            return TransactionResult.success(withValue: currentData)
        }
    }
    
    func addUserComponentDictFS(_ componentDbName: String, _ dictionary: Dictionary<String,Any>)
    {   /* This function uses Firestore and stores information.
         
            Timers / UID
                timerID
                name
                hour
                minute
                second
         */
        
        var FSdocRef: DocumentReference!
        guard let UID = Auth.auth().currentUser?.uid else { return }
        let ref = "/\(componentDbName)/\(UID)"
        FSdocRef = Firestore.firestore().document(ref)
        FSdocRef.setData(dictionary) { (error) in
            if let error = error {
                print("Oh no! \(error.localizedDescription)")
            } else {
                print("Data has been saved!")
            }
        }
    }
}
