//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 
 9.12.18 - Should I start over and just use layout? vs tableviewcontrollers?
 Doesn't seem like I'm getting any benefits from the added complexity.
 Layout rows underneath rows seems to be a better approach  .....
 The added tableview selectors and the mixing of view variables now
 in the controller side of the code kills the separation of form from function.
 At least I didn't kill off the timeline layout i did so I can quickly test
 that way to incorporate journaling, etc.
 
 let's make timelinescreen dynamic and see if that works better. Not sure
 what I'm giving up by not using tableviews but...
 
 9.15.18 - Still working on TimelineScreen instead of using the standard tableViewController
 
 
 
 TODO: 8.28.18 - DONE 9.4.18 - Create new tableview to drive the timeline calendar view
 TODO: 9.5.18 - DONE 9.5.18 - Fix date retrieval which is only an incrementer.
 TODO: 9.5.18 - DONE 9.8.18 - Change weekend text color. Could not use PARAM to work with BOOLs so pulled template into main xml file.
 TODO: 9.9.18 - DONE 9.9.18 - Initialize table row info with empty.
 TODO: 9.8.18 - DONE 9.11.18 - Added back background image to app. Had to put it in viewWillAppear
 TODO: 9.6.18 - DONE 9.11.18 - Use didSelectRowAt to create DayContainer component that is expandable
 TODO: 9.6.18 - DONE 9.11.18 - Expand row when tapped.
 TODO: 9.12.18 - Auto-close expanded view when another row is tapped.
 TODO: 9.11.18 - Fix strange expand animation.
 TODO: 9.8.18 - Read table info to self.days[] array (cloud)
 */

import UIKit
import Layout

class TimelineTableScreen: UITableViewController
{
    let numOfDays: Int = 30
    var isDayExpanded: Bool = false
    var isWeekend: Bool = false
    let sizeOfExpandedCell: Int = 200
    
    // Holder of DayContainer Components
    var days = [DayContainerComponent]()
    
    @IBOutlet var timelineTableView: UITableView?
    {
        didSet
        {
            timelineTableView?.registerLayout(
                named: "TimelineCell.xml",
                forCellReuseIdentifier: "timelineCell"
            )
        }
    }
    
    // https://github.com/schibsted/layout/blob/54c17632382ac6ebc479a8b5c4cdac301409e114/UIDesigner/TreeViewController.swift
    var layoutNode: LayoutNode?
    {
        didSet
        {
            timelineTableView?.reloadData()
            if layoutNode?.parent != nil {
                title = "Something there...."
            } else {
                title = "Nothing in layoutNode.parent thus Root"
            }
        }
    }
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Solve ERROR - 9.15.18 not solved.
        // Warning once only: Detected a case where constraints ambiguously suggest a height of zero
        // for a tableview cell's content view. We're considering the collapse unintentional and using standard height instead.
        self.tableView.rowHeight = 50
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "bk-1.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numOfDays
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let node = tableView.dequeueReusableHeaderFooterNode(withIdentifier: "timelineHeader")
        return node?.view as? UITableViewHeaderFooterView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Use special Layout extension method to dequeue the node rather than the view itself
        let cellNode = tableView.dequeueReusableCellNode(withIdentifier: "timelineCell", for: indexPath)
        
        // Initiazing days with empty values. Need to get cloud values once I get there.
        self.days.append(DayContainerComponent.init())
        let dayOfWeekIndex = DateSystem().getWeekDayIndex(index: indexPath.row)
        if dayOfWeekIndex == 0 || dayOfWeekIndex == 6 {
//            print("Weekend = Alright! \(dayOfWeekIndex)")
            isWeekend = true
        } else {
//            print("Weekday = Booo! \(dayOfWeekIndex)")
            isWeekend = false
        }
        
        // isDayExpanded is now a global variable but needs to be indexPath.row specific
//        if isDayExpanded {
//            print(DateSystem().getWeekDayText(index: indexPath.row), " content box is expanded!")
//        } else {
//            print(DateSystem().getWeekDayText(index: indexPath.row), " content box is closed!")
//        }
        
        // Set the node state to update the cell
        cellNode.setState([
            "month": DateSystem().getCurrentMonthText(),
            "year": DateSystem().currentYear,
            "dayText": DateSystem().getWeekDayText(index: indexPath.row),  // SUN - SAT
            "dayNumberText": DateSystem().getDay(index: indexPath.row),
            "isDayExpanded": false,
            "isWeekend": isWeekend,
            "sizeOfExpandedCell": sizeOfExpandedCell,
            "journal": self.days[indexPath.row].journalText,
        ])
        
        // Cast the node view to a table cell and return it
        return cellNode.view as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // https://stackoverflow.com/questions/37626282/swift-how-to-animate-the-rowheight-of-a-uitableview

        let cellNode = layoutNode?.children[indexPath.row]
        print("didSelectRowAt:", indexPath.row)

        if indexPath as NSIndexPath == self.selectedIndexPath {
            print("isDayExpanded selected same row: ", isDayExpanded)
            self.selectedIndexPath = nil
            cellNode?.setState([
                "isDayExpanded": false,
                "sizeOfExpandedCell": "50",
                ])
        } else {
            print("isDayExpanded selected different row: ", isDayExpanded)
            self.selectedIndexPath = indexPath as NSIndexPath
            cellNode?.setState([
                "isDayExpanded": true,
                "sizeOfExpandedCell": sizeOfExpandedCell,
                ])
        }
        
        // Initializing days with empty values. Need to get cloud values once I get there.
        // 9.11.18 - Does still need to be done?
//        self.days.append(DayContainerComponent.init())
        
        // Scroll to put selected row at top of scroll window
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    internal var selectedIndexPath: NSIndexPath?
    {
        didSet
        {
            //these magical lines tell the tableview something's up, and it checks cell heights and animates changes
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath as NSIndexPath == self.selectedIndexPath
        {
            let size = sizeOfExpandedCell
            return CGFloat(size)
        } else {
            return UITableView.automaticDimension
        }
    }

    // 9.15.18 - Set height of cell and estimated height too to remove ambiguously height warning.
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
}
