//
//  FirstViewController.swift
//  CircleShop
//
//  Created by yue zheng on 8/31/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit


class CircleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
                            
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_detail") {
            let destViewController = segue.destinationViewController as DetailViewController
            
            println(self.tableView.indexPathForSelectedRow()!.row)
            // datasource[row]
            //destViewController.image = self.tableView.indexPathForSelectedRow().row
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("CircleCell") as CircleViewCell
        
        let url = "http://d3lncrho1w0yzl.cloudfront.net/photo1.100x133.2642bytes.webp?1"
        cell.itemImageView.sd_setImageWithURL(NSURL(string: url))
//        cell.applyData(self.groups[indexPath.row])
        
        return cell
    }
 }
