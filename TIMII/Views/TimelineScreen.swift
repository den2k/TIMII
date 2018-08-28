//  Created by Daddy on 6/2/18.
//  Copyright © 2018 Autonomii. All rights reserved.
/*
 
 TODO: 8.18.18 - DONE (8.23.18) Change to Moleskine-like Timeline view
 TODO: 8.25.18 - DONE (8.27.18) Expand day view when tapped.
 TODO: 8.23.18 - prefersStatusBarHidden for iPhone X does not work. This code was added to deal with X but its not working.
 TODO: 8.28.18 - Show dates in view.
 TODO: 8.28.18 - Add Journal editing capability into this view ontap
 
8.25.18
Note: There is currently no safe way to explicitly bind a delegate to the layoutNode's owner class. Attempting
to pass self as a constant or state variable will result in a retain cycle (which is why owner-binding is done
implicitly rather than manually). This is why I'm getting a 'does not have an outlet named xxxxx' because the
layout file cannot find TimelineScreen class. If you package custom components into a separate module then you will need
to refer to them using their fully-qualified name in your XML.

*/

import UIKit
import Layout

class TimelineScreen: UIViewController, UIScrollViewDelegate, LayoutLoading
{
    @IBOutlet var timelineScrollView: UIScrollView?
    
    var isDayExpanded: Bool = false
    
    @IBOutlet var timelineScreenNode: LayoutNode? {
        didSet {
            timelineScreenNode?.setState([
                "isDayExpanded": isDayExpanded
            ])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView === self.timelineScrollView
        {
            print("scrolling...")
        }
    }
    
    @objc func expandView()
    {
        if isDayExpanded == true {
            print("Compress view.")
            isDayExpanded = false
            updateView()
        } else {
            print("Expand view.")
            isDayExpanded = true
            updateView()
        }
    }
    
    @objc func editView()
    {
        print("Editing view.")
    }
    
    @objc private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.timelineScreenNode?.setState([
            "isDayExpanded" : isDayExpanded
        ])
    }
}
