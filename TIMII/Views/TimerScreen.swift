//  Created by Daddy on 6/2/18.
//  Copyright © 2018 Autonomii. All rights reserved.

import UIKit

class TimerScreen: UIViewController, UIScrollViewDelegate
{
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var pageControl: UIPageControl?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView === self.scrollView
        {
            pageControl?.currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        }
    }
}
