//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 8.28.18 - DONE 9.4.18 - Create new tableview to drive the timeline calendar view
 */

import UIKit
import Layout

class TimelineTableScreen: UIViewController, UITableViewDataSource, UITableViewDelegate
{
//    var rowData: [String] = ["Who", "What", "Where", "Why"]
    var isDayExpanded: Bool = false
    var isWeekend: Bool = false

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let node = tableView.dequeueReusableHeaderFooterNode(withIdentifier: "timelineHeader")
        return node?.view as? UITableViewHeaderFooterView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Use special Layout extension method to dequeue the node rather than the view itself
        let cell = tableView.dequeueReusableCellNode(withIdentifier: "timelineCell", for: indexPath)
        
        let currentMonth = DateSystem().getCurrentMonthText()
        let currentYear = DateSystem().currentYear
        let dayNumberText = DateSystem().todaysDate + indexPath.row     // 1 - 31. Needs to be fixed.
        let dayText = DateSystem().getWeekDayText(index: indexPath.row) // SUN - SAT
        
        let day = DateSystem().getWeekDayIndex(index: indexPath.row)
        if day >= 5 {
            isWeekend = true
        } else {
            isWeekend = false
        }
        
        // Set the node state to update the cell
        cell.setState([
            "weekNumber": "XX",
            "month": currentMonth,
            "year": currentYear,
            "dayText": dayText,
            "dayNumberText": dayNumberText,
            "isDayExpanded": isDayExpanded,
            "isWeekend": isWeekend,
        ])
        
        // Cast the node view to a table cell and return it
        return cell.view as! UITableViewCell
    }
    
    @objc func expandView()
    {
        if isDayExpanded == true {
            print("Compress view.")
            isDayExpanded = false
//            updateView()
        } else {
            print("Expand view.")
            isDayExpanded = true
//            updateView()
        }
    }
    
//    @objc private func updateView()
//    {
//        // Calling setState() on a LayoutNode after it has been created will
//        // trigger an update. The update causes all expressions in that node
//        // and its children to be re-evaluated.
//        self.timelineScreenNode?.setState([
//            "isDayExpanded" : isDayExpanded
//            ])
//    }

}
