//
//  manageCircleViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/24/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//


import UIKit

//var circles = ["Nearby", "Explore"]

class ManageCircleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
//    var circles: [Circle]!
    var circles: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Manage"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ManageCircleViewCell") as manageCircleViewCellTableViewCell
        let circle = circles[indexPath.row]
        
        cell.textLabel.text = circle["name"] as String!
        cell.circle = circle
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            CurrentUser.removeCircle(circles[indexPath.row])
            self.circles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else {
            println("Unhandled editing style!")
        }
    }
}
