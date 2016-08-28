//
//  ViewController.swift
//  TableViewDateHeader
//
//  Created by Daniel Eisterhold on 8/27/16.
//  Copyright © 2016 Daniel Eisterhold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let dateFormatter = DERelativeDateFormatter()
    var dates = [NSDate]()
    var groupedDates = [String:[NSDate]]()
    var dateKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for a in 0..<100 {
            dates.append(NSDate(timeIntervalSinceNow: -86400 * Double(a)))
        }
        
        for date in dates {
            let dateString = dateFormatter.stringFromDate(date)
            if !groupedDates.keys.contains(dateString) {
                groupedDates[dateString] = [NSDate]()
            }
            
            groupedDates[dateString]?.append(date)
            if !dateKeys.contains(dateString) {
                dateKeys.append(dateString)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groupedDates.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedDates[dateKeys[section]]!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DateCell")!
        
        let date = groupedDates[dateKeys[indexPath.section]]![indexPath.row]
        
        cell.textLabel?.text = date.description
        print(date)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateKeys[section]
    }


}


