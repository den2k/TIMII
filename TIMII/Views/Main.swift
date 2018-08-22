//
//  Main.swift
//  TIMII
//
//  Created by Daddy on 4/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// TODO: 8.7.18 - Add if/then check for Countables related to SetupSystem
// TODO: 8.7.18 - Show Home Screen always even in logout/login

import UIKit
import Layout

class Main: UIViewController, LayoutLoading, UITabBarControllerDelegate
{
    private var selectedTab = 0     // Set to HomeScreen
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
 
        let login = LogInOutSystem()
        let signedIn = login.isLoggedIn()
        if !signedIn
        {
            perform(#selector(presentLogin), with: nil, afterDelay: 0)
        }

        print("Show Main / Home screen.")
        self.loadLayout(
            named: "Main.xml"
        )
        
        // 8.7.18 - Add this to MainVC and just do this once after reseting the database to Zero Node
        // then comment out. These setup the Countable Global variables.
        // SetupSystem().GlobalServiceSetup()
    }
    
    @objc func presentLogin()
    {
        print("Show Login screen.")
        let login = LoginScreen()
        present(login, animated: false, completion: nil)
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
}
