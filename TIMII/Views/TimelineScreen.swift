//  Created by Daddy on 6/2/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// 8.5.18
// This empty class is so the XML View Layout files can use the XML tag <HomeScreen> and reference
// the swift functions in this VC.
// TODO: 8.18.18 - Change to Moleskine-like Timeline view

import UIKit

class TimelineScreen: UIViewController, UIScrollViewDelegate
{
    @IBOutlet var timelineScrollView: UIScrollView?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView === self.timelineScrollView
        {
            print("scrolling...")
        }
    }
}
