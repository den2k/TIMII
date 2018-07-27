//
//  HelperViewController.swift
//  TIMII
//
//  Created by Daddy on 5/26/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import SnapKit

class HelperViewController : UIViewController
{
    let inputContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    func setupProfileImageView(){
        //need x, y, width , height
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
    
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
    

}
    

