//
//  LogInOutSystem.swift
//  TIMII
//
//  Created by Dennis Huang on 8/19/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Firebase

class LogInOutSystem : UIViewController
{
    @objc public func handleLogout()
    {
        print("Attempting to logout...")
        do {
            try Auth.auth().signOut()
            print("Signed out!!")
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    func isLoggedIn() -> Bool
    {
        print("Checking if user is login...")
        if Auth.auth().currentUser?.uid == nil
        {
            print("User is not signed in.")
            return false
        }
        else
        {
            print("User is signed in.")
            return true
        }
    }
}
