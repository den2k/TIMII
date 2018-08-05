//
//  Main.swift
//  TIMII
//
//  Created by Daddy on 4/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Layout
import Firebase

class Main: UIViewController, LayoutLoading, UITabBarControllerDelegate
{
    private var selectedTab = 0     // Set to HomeScreen
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        
//        navigationController?.isNavigationBarHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))

        self.loadLayout(
            named: "Main.xml"
        )
    }
    
    func layoutDidLoad(_ layoutNode: LayoutNode)
    {
        guard let tabBarController = layoutNode.viewController as? UITabBarController else { return }
        tabBarController.selectedIndex = selectedTab
        tabBarController.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        guard let index = tabBarController.viewControllers?.index(of: viewController) else { return }
        selectedTab = index
    }
    
    // 7.30.18 - Always call from 'main' VC and not from the login VC because
    // 'dismiss' and not 'present' is best practice.
    // https://www.reddit.com/r/swift/comments/817mgv/dismiss_vs_present_view_controller/
    @objc func handleLogout()
    {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let login = LoginScreen()
        print("Present Login Screen.")
        present(login, animated: false, completion: nil)
    }
    
    func checkIfUserIsLoggedIn()
    {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else
        {
            print("User is signed in.")
            return
        }
    }
}

// Add this to MainVC and just do this once after reseting the database to Zero Node
// then comment out. These setup the Countable Global variables.
// SetupSystem().GlobalServiceSetup()
