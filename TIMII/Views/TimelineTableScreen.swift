//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 8.28.18 - DONE 9.4.18 - Create new tableview to drive the timeline calendar view
 TODO: 9.5.18 - DONE 9.5.18 - Fix date retrieval which is only an incrementer.
 TODO: 9.6.18 - Expand row when tapped.
 */

import UIKit
import Layout

class TimelineTableScreen: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let numOfDays: Int = 30
    var isDayExpanded: Bool = false
    var isWeekend: Bool = false
    
    // TODO: 9.6.18 - create DayContainer component that is expandable
    // var days: [DayContainerComponent]
    var days: [String] = Array(repeating: "hi. ", count: 60)

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
        return numOfDays
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let node = tableView.dequeueReusableHeaderFooterNode(withIdentifier: "timelineHeader")
        return node?.view as? UITableViewHeaderFooterView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Use special Layout extension method to dequeue the node rather than the view itself
        let cell = tableView.dequeueReusableCellNode(withIdentifier: "timelineCell", for: indexPath)
        
        let day = DateSystem().getWeekDayIndex(index: indexPath.row)
        
        print(indexPath.row)
        
        if day == 0 || day == 6 {
            print("Weekend alright! \(day)")
            isWeekend = true
        } else {
            print("Weekday booo! \(day)")
            isWeekend = false
        }
        
        // Set the node state to update the cell
        cell.setState([
//            "weekNumber": "XX",
            "month": DateSystem().getCurrentMonthText(),
            "year": DateSystem().currentYear,
            "dayText": DateSystem().getWeekDayText(index: indexPath.row),  // SUN - SAT
            "dayNumberText": DateSystem().getDay(index: indexPath.row),
            "isDayExpanded": isDayExpanded,
            "isWeekend": isWeekend,
        ])
        
        // Cast the node view to a table cell and return it
        return cell.view as! UITableViewCell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        // 1
//        guard let dayCell = tableView.cellForRow(at: indexPath) else { return }
//
//        var day = days[indexPath.row]
//
//        // toggles isExpanded flag in days array
//        day.isExpanded = !day.isExpanded
//        days[indexPath.row] = day       // do this line only if structs passed by copy
        
        // 3 https://www.raywenderlich.com/1067-self-sizing-table-view-cells
//        dayCell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
//        dayCell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center

//        let notExpanded = "Why not type something."
//        let expanded = "Working 9 to 5 programming my way to billions!"
//
//        day.append(contentsOf: expanded)
//
//        cell.setState([
//            //            "weekNumber": "XX",
//            "month": DateSystem().getCurrentMonthText(),
//            "year": DateSystem().currentYear,
//            "dayText": DateSystem().getWeekDayText(index: indexPath.row),  // SUN - SAT
//            "dayNumberText": DateSystem().getDay(index: indexPath.row),
//            "isDayExpanded": isDayExpanded,
//            "isWeekend": isWeekend,
//            ])
//
//        // 4
//        tableView.beginUpdates()
//        tableView.endUpdates()
    
//        // 5
//        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//    }
    
//    @objc func expandView()
//    {
//        if isDayExpanded == true {
//            print("Compress view.")
//            isDayExpanded = false
////            updateView()
//        } else {
//            print("Expand view.")
//            isDayExpanded = true
////            updateView()
//        }
//    }
//    
//    @objc private func updateView()
//    {
//        // Calling setState() on a LayoutNode after it has been created will
//        // trigger an update. The update causes all expressions in that node
//        // and its children to be re-evaluated.
//        timelineTableView?.setState([
//            "isDayExpanded" : isDayExpanded
//            ])
//    }

}
