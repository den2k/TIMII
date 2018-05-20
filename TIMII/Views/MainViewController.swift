//
//  ViewController.swift
//  TIMII
//
//  Created by Daddy on 4/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray

        // Just do this once after reseting the database to Zero Node
        // then comment out. These setup the Countable Global variables.
        // SetupSystem().GlobalServiceSetup()
        
        
        //  TODO: remove UUID use. Use sequential IDs or FB Push iDs or ....
        let uid1 = UUID().uuidString
        let board1 = DashboardSystem(uid1)
        board1.addDashboard(uid1, "uid1 - 2nd Dashboard")

        print(board1.UIType)
        print(board1.isViewable)
        
    }
}
