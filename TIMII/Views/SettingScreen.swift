//
//  SettingScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/5/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// 8.5.18 - This class exist as the 'controller' for our 'views' (XML) that can be referenced using the XML tag (ie; <SettingsScreen>)
//

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
