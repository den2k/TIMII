//
//  TopViewController.swift
//  TIMII
//
//  Created by Daddy on 5/26/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
import SnapKit

class TopViewController: UIViewController
{
    // Logo Bar + Family and Friends Bar using SnapKit
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(rgb: 0xFCFCFC)
        navigationController?.isNavigationBarHidden = true
        
        // Logo Bar with SnapKit
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
                make.center.equalTo(logoBar)
        }
        
        // Family and Friends Bar with SnapKit
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
        
        // idCircleContainer with SnapKit
        let idCircleContainer = UIView()
        let idCircleContainerHeight = FFBarHeight - 1
        FFBar.addSubview(idCircleContainer)
        idCircleContainer.backgroundColor = UIColor.white
        idCircleContainer.snp.makeConstraints
            { (make) -> Void in
                // top, right, bottom, left
                make.center.equalTo(FFBar)
                make.height.equalTo(idCircleContainerHeight)
                make.width.equalTo(FFBar)
        }
    }
}
*/
