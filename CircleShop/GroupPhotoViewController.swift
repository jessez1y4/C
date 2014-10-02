//
//  PostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit
import AssetsLibrary

var whichImage: UInt = 1

class GroupPhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let assetsLibrary = GroupPhotoViewController.defaultAssetsLibrary()
    var groups:[ALAssetsGroup] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.tableView.registerClass(GroupPhotoViewCell.self, forCellReuseIdentifier: "GroupPhotoCell")
        
        assetsLibrary.enumerateGroupsWithTypes(0xFFFFFFFF,
            usingBlock: {(group: ALAssetsGroup!, stop: UnsafeMutablePointer<ObjCBool>) in
                if(group != nil){
                    println(group)
                    self.groups.append(group)
                }
                else
                {
                    // reload data
                    self.tableView.reloadData()
                }
                
            }, failureBlock: { (error:NSError!) in
                println("Problem loading albums: \(error)")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_album") {
            let destViewController = segue.destinationViewController as PhotoCollectionViewController
            destViewController.group = self.groups[self.tableView.indexPathForSelectedRow()!.row]
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("GroupPhotoCell") as GroupPhotoViewCell
        cell.applyData(self.groups[indexPath.row])
        
        return cell
    }
    


    
    //    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    //        println("You selected cell #\(indexPath.row)!")
    //    }
    
    
    class func defaultAssetsLibrary() -> ALAssetsLibrary {
        return ALAssetsLibrary()
    }
}
