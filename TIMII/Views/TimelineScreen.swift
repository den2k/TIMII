//  Created by Daddy on 6/2/18.
//  Copyright © 2018 Autonomii. All rights reserved.
/*
 
 TODO: 8.18.18 - DONE (8.23.18) Change to Moleskine-like Timeline view
 TODO: 8.25.18 - DONE (8.27.18) Expand day view when tapped.
 TODO: 8.23.18 - DEL (9.16.18) prefersStatusBarHidden for iPhone Xx does not work. This code was added to deal with X but its not working.  Fixed using layout and adding padding from subview.
 TODO: 8.28.18 - DONE (9.16.18) Show dates in view.
 TODO: 8.28.18 - Add Journal editing capability into this view on tap
 
8.25.18
Note: There is currently no safe way to explicitly bind a delegate to the layoutNode's owner class. Attempting
to pass self as a constant or state variable will result in a retain cycle (which is why owner-binding is done
implicitly rather than manually). This is why I'm getting a 'does not have an outlet named xxxxx' because the
layout file cannot find TimelineScreen class. If you package custom components into a separate module then you will need
to refer to them using their fully-qualified name in your XML.

 9.13.18 - I stopped working on this screen view controller because I could not figure out
 how to increment a row between VC and the layout views. So I moved on to using a regular
 tableViewController which worked after a lot of hacking. But I just couldn't figure out
 how to present the info the way I wanted. The inflexibility and more complex coding made
 simple things like enlarging the cell height very hard.  So I am back to this VC.
 But I'm back to where I started which is not being able to identiy the indexPath.row value
 being presented by the view, making it much harder to increment/decrement the date.
 Looking at the date stamp on adding dates to this view, it was 2 weeks ago....8.28.
 
 
*/

import UIKit
import Layout

class TimelineScreen: UIViewController, UIScrollViewDelegate, LayoutLoading
{
    @IBOutlet var timelineScrollView: UIScrollView?
    var isDayExpanded: Bool = false
    var offsetDate: Int = 0
    var dateString: String = ""
    
    @IBOutlet var timelineScreenNode: LayoutNode? {
        didSet {
            timelineScreenNode?.setState([
                "isDayExpanded": isDayExpanded,
                "month": DateSystem().getCurrentMonthText(),
                "year": DateSystem().currentYear,
                "dayText0": DateSystem().getWeekDayText(index: offsetDate),     // SUN - SAT
                "dayText1": DateSystem().getWeekDayText(index: offsetDate+1),
                "dayText2": DateSystem().getWeekDayText(index: offsetDate+2),
                "dayText3": DateSystem().getWeekDayText(index: offsetDate+3),
                "dayText4": DateSystem().getWeekDayText(index: offsetDate+4),
                "dayText5": DateSystem().getWeekDayText(index: offsetDate+5),
                "dayText6": DateSystem().getWeekDayText(index: offsetDate+6),
                "dayNumberText": DateSystem().getDay(index: offsetDate),
                "isWeekend": DateSystem().isWeekend(dayOfWeekIndex: offsetDate),
//                "journal": self.days[offsetDate].journalText,
            ])
        }
    }
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(animated)
//
//        // Add a background view to the table view
//        let backgroundImage = UIImage(named: "bk-1.jpg")
//        let imageView = UIImageView(image: backgroundImage)
//        self.tableView.backgroundView = imageView
//    }
    
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
