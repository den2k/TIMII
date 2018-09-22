//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 
 --- JOURNAL ---
 
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
 
 9.16.18 - TableView is all messed up because it shares views with TimelineScreen.
 
 9.17.18 - Finally got the expand tablecell to work!!!! I had to issue a reload
 data on the entire table which is expansive but may be ok.... I also had to
 save the state of a Day Component being expanded or not
 in its own component instance. Only then could I use the expanded flag
 inside the XML views to intelligently open and close a view.....!!!!!!
 Note that the tableview doesn't reload in real-time using the following commands.

    self.tableView.beginUpdates()     // doesn't do a complete reload of the table so not real-time
    self.tableView.endUpdates()       // doesn't do a complete reload of the table so not real-time

 it must be
    self.tableView.reloadData()
 
 --- TODO ---
 
 TODO: 8.28.18 [DONE 9.4.18] - Create new tableview to drive the timeline calendar view
 TODO: 9.5.18 [DONE 9.5.18] - Fix date retrieval which is only an incrementer.
 TODO: 9.5.18 [DONE 9.8.18] - Change weekend text color. Could not use PARAM to work with BOOLs so pulled template into main xml file.
 TODO: 9.9.18 [DONE 9.9.18] - Initialize table row info with empty.
 TODO: 9.8.18 [DONE 9.11.18] - Added back background image to app. Had to put it in viewWillAppear
 TODO: 9.6.18 [DONE 9.11.18] - Use didSelectRowAt to create DayContainer component that is expandable
 TODO: 9.6.18 [DONE 9.11.18] - Expand row when tapped.
 TODO: 9.6.18 [DONE 9.17.18] - Expand row when tapped. Close row when tapped.
 TODO: 9.17.18 [DONE 9.17.18] - Refactor didSelectRowAt to shrink code. So it does not use the following:
 https://stackoverflow.com/questions/37626282/swift-how-to-animate-the-rowheight-of-a-uitableview

 TODO: 9.12.18 - Auto-close expanded view when another row is tapped.
 TODO: 9.8.18 - Read table info to self.days[] array (cloud)
 TODO: 9.19.18 - Add journal function to daycontainer

 */

import UIKit
import Layout

class TimelineTableScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate
{
    let numOfDays: Int = 30
    var isWeekend: Bool = false
    var days: [DayComponent] = []
    
    @objc @IBOutlet var journalTextView: UITextView?
    
    // Using registerLayout allows the cell XML definition to be a separate file that is not inside
    // the table view controller.
    @IBOutlet var timelineTableView: UITableView?
    {
        didSet
        {
            print("registerlayout")
            timelineTableView?.registerLayout(
                named: "TimelineCell.xml",
                forCellReuseIdentifier: "timelineCell"
            )
        }
    }
    
    // Need to bind the outlet to the View Controller so I need to create a reference to the
    // layout node and use viewDidload....?
    @objc var layoutNode: LayoutNode?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfDays
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        print("this kicks #2 load: viewforheaderinsection...")
        let node = tableView.dequeueReusableHeaderFooterNode(withIdentifier: "timelineHeader")
        return node?.view as? UITableViewHeaderFooterView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Use special Layout extension method to dequeue the node rather than the view itself
        let cellNode = tableView.dequeueReusableCellNode(withIdentifier: "timelineCell", for: indexPath)
        
        self.days.append(DayComponent.init(day: Date(timeIntervalSinceNow: Double(indexPath.row) * 24.0 * 3600.0)))     // timeInterval workings in milliseconds hence the calculations to represent 1 day

        let dayOfWeekIndex = DateSystem().getWeekDayIndex(index: indexPath.row)
        if dayOfWeekIndex == 0 || dayOfWeekIndex == 6 {
            isWeekend = true
        } else {
            isWeekend = false
        }
        
        self.layoutNode = LayoutNode(
            view: UITableViewCell.self,
            children: [
                LayoutNode(
                    view: UIView.self,
                    children: [
                        LayoutNode(
                            view: UITextView.self,
                            outlet: #keyPath(journalTextView)
                        )
                    ]
                )
            ]
        )
    
        cellNode.setState([
            "index": indexPath.row,
            "month": DateSystem().getCurrentMonthText(),
            "year": DateSystem().currentYear,
            "dayText": days[indexPath.row].getDayText(index: indexPath.row),                // SUN - SAT
            "dayNumberText": days[indexPath.row].getDayNumberText(index: indexPath.row),    // 1 - 31
            "isDayExpanded": days[indexPath.row].isExpanded,
            "isWeekend": isWeekend,
            "journal": journalTextView?.text as Any,
            ])
        
        print(indexPath.row, ":cellForRowAt:", days[indexPath.row].isExpanded)
        print("journal:", journalTextView?.text as Any)
        
        // Cast the node view to a table cell and return it
        return cellNode.view as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        days[indexPath.row].isExpanded = !days[indexPath.row].isExpanded
        print(indexPath.row, ":isExpanded:",days[indexPath.row].isExpanded)
        tableView.reloadData()
    }
    
    @objc func journalEntry()
    {
        print("Journal Saved!")
        guard let j = journalTextView?.text else { return }
        print("journal:", j)
    }
    
//    @objc func expandDay(index: Int)
//    {
//        days[index].isExpanded = !days[index].isExpanded
//    }
}
