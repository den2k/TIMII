//
//  TimelineTableScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 8/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
 TODO: 8.28.18 - Create new tableview to drive the timeline calendar view
 */

import UIKit
import Layout

class TimelineTableScreen: UIViewController, UITableViewDataSource, UITableViewDelegate
{
//    var rowData: [String] = ["Who", "What", "Where", "Why"]
    
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
        
        let now = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: now)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: now)

        
        // Set the node state to update the cell
        cell.setState([
            "weekNumber": "XX",
            "month": nameOfMonth,
            "year": year,
            "day": day,
        ])
        
        // Cast the node view to a table cell and return it
        return cell.view as! UITableViewCell
    }
}
