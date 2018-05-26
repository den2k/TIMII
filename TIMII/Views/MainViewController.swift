//
//  ViewController.swift
//  TIMII
//
//  Created by Daddy on 4/15/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import SnapKit

class MainViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(rgb: 0xFCFCFC)
        navigationController?.isNavigationBarHidden = true

        // Logo Bar
        let logoBar = UIView()
        let logoHeaderHeight = 30
        view.addSubview(logoBar)
        logoBar.backgroundColor = UIColor.init(rgb: 0xFCFCFC)
        logoBar.snp.makeConstraints
            { (make) -> Void in
                // top, right, bottom, left
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                make.height.equalTo(logoHeaderHeight)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
        }
        
        let appName = UILabel()
        logoBar.addSubview(appName)
        appName.textColor = UIColor.init(rgb: 0x404040)
        appName.text = "TIMII"
        appName.snp.makeConstraints
            { (make) -> Void in
                // top, right, bottom, left
                make.centerX.equalTo(logoBar)
                make.centerY.equalTo(logoBar)
        }

        // Family and Friends Bar
        let FFBar = UIView()
        let FFBarHeight = 80
        view.addSubview(FFBar)
        FFBar.backgroundColor = UIColor.init(rgb: 0xE5E5E5)
        FFBar.snp.makeConstraints
        { (make) -> Void in
            // top, right, bottom, left
            make.top.equalTo(logoBar.snp.bottom)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(FFBarHeight)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
        }
        
        // idCircleContainer
        let idCircleContainer = UIView()
        let idCircleContainerHeight = FFBarHeight - 1
        FFBar.addSubview(idCircleContainer)
        idCircleContainer.backgroundColor = UIColor.white
        idCircleContainer.snp.makeConstraints
        { (make) -> Void in
            // top, right, bottom, left
            make.centerY.equalTo(FFBar.snp.centerY)
            make.right.equalTo(FFBar.snp.right)
            make.height.equalTo(idCircleContainerHeight)
            make.left.equalTo(FFBar.snp.left)
        }
        
        

        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dashboard", style: .plain, target: self, action: #selector(handleDash))
        
    }
    
    @objc func handleDash()
    {
        // Transition with Back button to DashboardViewController
        let dVC = DashboardViewController()
        let navController = UINavigationController(rootViewController: dVC)
        present(navController, animated: true, completion: nil)
    }
}

// Add this to MainVC and just do this once after reseting the database to Zero Node
// then comment out. These setup the Countable Global variables.
// SetupSystem().GlobalServiceSetup()


//  TODO: remove UUID use. Use sequential IDs or FB Push iDs or ....
//        let uid1 = UUID().uuidString
//        let board1 = DashboardSystem(uid1)
//        board1.addDashboard(uid1, "uid1 - 2nd Dashboard")
//
//        print(board1.UIType)
//        print(board1.isViewable)
//
