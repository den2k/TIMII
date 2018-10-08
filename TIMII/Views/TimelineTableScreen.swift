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
 TODO: 9.19.18 - [DONE 9.27.18] Add journal function to daycontainer. Still not working
 TODO: 9.21.18 [DONE 9.21.18] Add timer to TableCell
 TODO: 9.22.18 - Show timer only when Timer icon is pressed....
 TODO: 9.23.18 - Rebuild DayComponent using the tutorial Table View with multiple cell types.
 TODO: 9.27.18 - Why does an entry in row 1 go into 11 21...Why does an entry in row 0 go into 10 20....
 
 --- NOTES ---
 
 10.7 - createDates() - Pulled the creation of new days via append into a function outside of the cellForRowAt function
 because that function continueously generates new days as it cycles through display more cells, even current cells during
 a scroll event.  No need to do this.  Automately the requirement is to show new days, but not create new days.
 Once a new journal or timer entry is created then timestamp that information and associate it to the date, then pull this
 information into the day displayed. It is total wrong to create days in advance. It's not even necessary to create days.
 Just day information. I may have done this initially because of Layout... hmmm.

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
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var timelineTableView: UITableView?
    {
        didSet
        {
            print("registerlayout:createDates")
            createDates()
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
        let node = tableView.dequeueReusableHeaderFooterNode(withIdentifier: "timelineSection")
        return node?.view as? UITableViewHeaderFooterView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Use special Layout extension method to dequeue the node rather than the view itself
        let cellNode = tableView.dequeueReusableCellNode(withIdentifier: "timelineCell", for: indexPath)
        cellIndex = indexPath.row
        
//        self.days.append(DayComponent.init(day: Date(timeIntervalSinceNow: Double(cellIndex) * 24.0 * 3600.0)))     // timeInterval workings in milliseconds hence the calculations to represent 1 day

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
            "journal": journalTextView?.text as Any,
            ])
        
//        print(cellIndex, ": date: ", days[cellIndex].thisDay)
//        print(cellIndex, ": cellForRowAt: ", days[cellIndex].isExpanded)
//        print(cellIndex, ": Journal: ", days[cellIndex].journalPost.post)
        
        let cell = cellNode.view as! TimelineCell             // get the outlet contained in the class TimelineCell
        self.journalTextView = cell.journalTextView
//        print(cell.journalTextView?.text)
//        print(cellIndex, ": Journal: ", days[cellIndex].journalPost.post)
//        days[cellIndex].journalPost.post = cell.journalTextView?.text ?? "non"
        
        // Cast the node view to a table cell and return it
        //return cellNode.view as! UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // get selectedDate
//        print(days[indexPath.row].thisDay)
//        selectedDate = days[indexPath.row].thisDay
        print(self.journalTextView?.text)
        selectedRowIndex = indexPath.row
        print("selectedRowIndex: ", selectedRowIndex)
        
        days[indexPath.row].isExpanded = !days[indexPath.row].isExpanded
        print(indexPath.row, ": isExpanded: ",days[indexPath.row].isExpanded, ": date: ", days[indexPath.row].thisDay)
        
//        tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
        
//        tableView.reloadData()          // this animates in real-time expanding and !expanding a row.
        timelineTableView?.reloadRows(at: [indexPath], with: .none)
    }
    
    func createDates()
    {
        // Its strange that we need to create 30 days worth each time this tableview kicks off.
        // How else should I do this. I don't want to precreate a ton of stored data....this is why
        // this is created at run time.
        for i in 1...numOfDays
        {
            // timeInterval workings in milliseconds hence the calculations to represent 1 day
            self.days.append(DayComponent.init(day: Date(timeIntervalSinceNow: Double(i) * 24.0 * 3600.0)))
        }
    }
    
    @objc func journalEntry()
    {
//        guard let journal = self.journalTextView?.text else { return }
        // replace selectedRowIndex with selectedDate index so it properuse the get selectedDate and enter the journalPost using selectedDate
        // Why does an entry in row 1 go into 11 21....
        // Why does an entry in row 0 go into 10 20....
        days[selectedRowIndex].journalPost.post = self.journalTextView!.text
//        days[selectedRowIndex].journalPost.post = "wow"
        print("Journal Saved!")
        print(selectedRowIndex,": journalEntry: ", self.journalTextView?.text as Any)
        print(selectedRowIndex,": days[journalPost]: ", days[selectedRowIndex].journalPost.post)
        
        let indexPath = IndexPath(row: selectedRowIndex, section: 0)
        timelineTableView?.reloadRows(at: [indexPath], with: .none)
    }
    
    @objc func timerButton()
    {
        print("Pressed timer button.")
        days[selectedRowIndex].showTimer = !days[selectedRowIndex].showTimer
        
        
        
//          self.layoutNode?.setState(["showTimer": true])
//        print(cellIndex, ": Show Timer: ", days[cellIndex].showTimer)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(self.journalTextView?.text as Any)
    }
}
