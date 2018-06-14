//
//  Main.swift
//  TIMII
//
//  Created by Daddy on 4/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Layout

class Main: UIViewController, LayoutLoading, UITabBarControllerDelegate
{
    private var selectedTab = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        self.loadLayout(
            named: "Main.xml"
        )
        
    }
    
    func layoutDidLoad(_ layoutNode: LayoutNode) {
        guard let tabBarController = layoutNode.viewController as? UITabBarController else {
            return
        }
        
        tabBarController.selectedIndex = selectedTab
        tabBarController.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = tabBarController.viewControllers?.index(of: viewController) else {
            return
        }
        selectedTab = index
    }
}

// Add this to MainVC and just do this once after reseting the database to Zero Node
// then comment out. These setup the Countable Global variables.
// SetupSystem().GlobalServiceSetup()
