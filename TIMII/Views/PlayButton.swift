//
//  PlayButton.swift
//  TIMII
//
//  Created by Daddy on 7/7/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Layout

class PlayButton : UIViewController
{
    var toggled = false
    {
        didSet
        {
            playButton?.setState(["isToggled": toggled])
        }
    }
    
    @IBOutlet var playButton: LayoutNode?
    {
        didSet
        {
            playButton?.setState(["isToggled": toggled])
        }
    }
    
    @IBAction func setToggled()
    {
        UIView.animate(withDuration: 0.2)
        {
            self.toggled = true
        }
    }
    
    @IBAction func setUntoggled()
    {
        UIView.animate(withDuration: 0.2)
        {
            self.toggled = false
        }
    }
    
}

