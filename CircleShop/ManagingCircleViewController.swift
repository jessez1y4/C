//
//  ManagingCircleViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/22/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class ManagingCircleViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var circles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        for (var i = 1; i <= 10; i++) {
            circles.append(String("item \(i)"))
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        //        if(segue.identifier == "show_detail") {
        //            let destViewController = segue.destinationViewController as DetailViewController
        //
        //            println(self.tableView.indexPathForSelectedRow()!.row)
        //            // datasource[row]
        //            //destViewController.image = self.tableView.indexPathForSelectedRow().row
        //        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ManagingCircleViewCell") as UITableViewCell
        
        cell.textLabel!.text = circles[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            circles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            println("123")
        } else {
            println("Unhandled editing style!")
        }
    }
}
