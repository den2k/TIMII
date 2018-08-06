//
//  SettingScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/5/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// 8.5.18 - This empty class is so the XML View Layout files can use the XML tag <HomeScreen> and reference
// the swift functions in this VC.

import UIKit
import Firebase

class SettingScreen: UIViewController
{
    @objc func handleLogout()
    {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let login = LoginScreen()
        print("Present Login Screen.")
        present(login, animated: true, completion: nil)
    }
}
