//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 
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
 TODO: 9.19.18 - Add journal function to daycontainer. Still not working
 TODO: 9.21.18 [DONE 9.21.18] Add timer to TableCell
 TODO: 9.22.18 - Show timer only when Timer icon is pressed....
 TODO: 9.23.18 - Rebuild DayComponent using the tutorial Table View with multiple cell types.

 */

import UIKit
import Layout

class TimelineTableScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, LayoutLoading
{
    let numOfDays: Int = 30
    var isWeekend: Bool = false
    var days: [DayComponent] = []
    var cellIndex: Int = 0
    var selectedRowIndex: Int = 0
//    var selectedDate: Date = Date()
    
    var journalTextView: UITextView?
    
    // Using registerLayout allows the cell XML definition to be a separate file that is not inside
    // the table view controller file.
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
        cellIndex = indexPath.row
        
        self.days.append(DayComponent.init(day: Date(timeIntervalSinceNow: Double(cellIndex) * 24.0 * 3600.0)))     // timeInterval workings in milliseconds hence the calculations to represent 1 day

        let dayOfWeekIndex = DateSystem().getWeekDayIndex(index: indexPath.row)
        
        if dayOfWeekIndex == 0 || dayOfWeekIndex == 6 { isWeekend = true }
        else { isWeekend = false }
        
        cellNode.setState([
            "month": DateSystem().getCurrentMonthText(),
            "year": DateSystem().currentYear,
            "dayText": days[cellIndex].getDayText(index: cellIndex),                // SUN - SAT
            "dayNumberText": days[cellIndex].getDayNumberText(index: cellIndex),    // 1 - 31
            "isDayExpanded": days[cellIndex].isExpanded,
            "isWeekend": isWeekend,
            "showTimer": days[cellIndex].showTimer,                    // shows or hides timer in cell
            "journal": days[cellIndex].journalPost.post,
            ])
        
//        print(cellIndex, ": date: ", days[cellIndex].thisDay)
//        print(cellIndex, ": cellForRowAt: ", days[cellIndex].isExpanded)
//        print(cellIndex, ": Journal: ", days[cellIndex].journalPost.post)
        
        let cell = cellNode.view as! TimelineCell             // get the outlet contained in the class TimelineCell
        self.journalTextView = cell.journalTextView
        print(cellIndex, ": Journal: ", self.journalTextView!.text)
//        days[cellIndex].journalPost.post = cell.journalTextView?.text ?? "non"
        
        // Cast the node view to a table cell and return it
        return cellNode.view as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // get selectedDate
//        print(days[indexPath.row].thisDay)
//        selectedDate = days[indexPath.row].thisDay
        selectedRowIndex = indexPath.row
        days[indexPath.row].isExpanded = !days[indexPath.row].isExpanded
        print(indexPath.row, ": isExpanded: ",days[indexPath.row].isExpanded)
        tableView.reloadData()          // this makes expanding and !expanding a row work.
    }
    
    @objc func journalEntry()
    {
//        guard let journal = self.journalTextView?.text else { return }
        // replace selectedRowIndex with selectedDate index so it properuse the get selectedDate and enter the journalPost using selectedDate
        // Why does an entry in row 1 go into 11 21....
        // Why does an entry in row 0 go into 10 20....
        days[selectedRowIndex].journalPost.post = self.journalTextView?.text ?? "nothing..."
        print("Journal Saved!")
        print(selectedRowIndex,": journalEntry: ", days[selectedRowIndex].journalPost.post)
    }
    
    @objc func timerButton()
    {
        print("Pressed timer button.")
//        days[cellIndex].showTimer = !days[cellIndex].showTimer
//        self.layoutNode?.setState(["showTimer": true])
//        print(cellIndex, ": Show Timer: ", days[cellIndex].showTimer)
    }
    
}
