//
//  OldDashboardViewController.swift
//  TIMII
//
//  Created by Daddy on 5/19/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
import SnapKit

class OldDashboardViewController : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray

        let topLeftBox = UIView()
        view.addSubview(topLeftBox)
        topLeftBox.backgroundColor = UIColor.blue
        topLeftBox.snp.makeConstraints
        { (make) -> Void in
            // top, right, bottom, left
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).dividedBy(2)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).dividedBy(2)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
        }
        
        let topRightBox = UIView()
        view.addSubview(topRightBox)
        topRightBox.backgroundColor = UIColor.orange
        topRightBox.snp.makeConstraints
        { (make) -> Void in
            // top, right, bottom, left
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).dividedBy(2)
            make.left.equalTo(topLeftBox.snp.right).offset(16)
        }
        
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }

    @objc func handleCancel()
    {
        dismiss(animated: true, completion: nil)
    }
}
*/
