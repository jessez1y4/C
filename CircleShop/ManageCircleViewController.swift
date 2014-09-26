//
//  manageCircleViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/24/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//


import UIKit

var circles = ["Nearby", "Explore"]

class ManageCircleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var snapshot: UIView? = nil
    var sourceIndexPath: NSIndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (var i = 1; i <= 10; i++) {
            circles.append(String("item \(i)"))
        }
        
        var longPress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        self.tableView.addGestureRecognizer(longPress)
    }
    
    @IBAction func longPressGestureRecognized(sender: AnyObject) {
    
        var longPress = sender as UILongPressGestureRecognizer
        var state = longPress.state;

        var location = longPress.locationInView(self.tableView)
        var indexPath = self.tableView.indexPathForRowAtPoint(location)
        
        

        switch (state) {
            case UIGestureRecognizerState.Began:
                if let index = indexPath {
                    sourceIndexPath = index;
                    
                    var cell = self.tableView.cellForRowAtIndexPath(index)
                    
                    // Take a snapshot of the selected row using helper method.
                    snapshot = self.customSnapshotFromView(cell!)
                    
                    // Add the snapshot as subview, centered at cell's center...
                    var center = cell!.center;
                    self.snapshot!.center = center;
                    self.snapshot!.alpha = 0.0;
                    self.tableView.addSubview(self.snapshot!)
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        center.y = location.y;
                        self.snapshot!.center = center;
                        self.snapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05);
                        self.snapshot!.alpha = 0.98;
                        cell!.alpha = 0.0;
                    }, completion: { (Bool) -> Void in
                        cell!.hidden = true
                    })
                }
            case UIGestureRecognizerState.Changed:
                if let existSnapshot = self.snapshot {
                    var center = existSnapshot.center;
                    center.y = location.y;
                    existSnapshot.center = center;
                    
                    // Is destination valid and is it different from source?
                    if (indexPath != nil && indexPath!.isEqual(sourceIndexPath) == false) {
                        
                        // ... update data source.
                        swap(&circles[indexPath!.row], &circles[sourceIndexPath!.row])
    
                        // ... move the rows.
                        self.tableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: indexPath!)
                        
                        // ... and update source so it is in sync with UI changes.
                        sourceIndexPath = indexPath;
                    }
                }
        default:
            // Clean up.
            if let existSourceIndexPath = sourceIndexPath{
                var cell = self.tableView.cellForRowAtIndexPath(sourceIndexPath!)
            
                if let existCell = cell{
                    existCell.hidden = false
                    existCell.alpha = 0.0
                
                
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        if let existSnapshot = self.snapshot{
                            existSnapshot.center = existCell.center;
                            existSnapshot.transform = CGAffineTransformIdentity;
                            existSnapshot.alpha = 0.0;
                            
                            // Undo fade out.
                            existCell.alpha = 1.0
                        }

                    }, completion: { (Bool) -> Void in
                        self.sourceIndexPath = nil
                        self.snapshot!.removeFromSuperview()
                        self.snapshot = nil
                    })
                }
            }
        }
    }
    
    
    func customSnapshotFromView(inputView: UIView) -> UIView {
        var snapshot = inputView.snapshotViewAfterScreenUpdates(true)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
        snapshot.layer.shadowRadius = 5.0;
        snapshot.layer.shadowOpacity = 0.4;
        return snapshot;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier("ManageCircleViewCell") as manageCircleViewCellTableViewCell
        
        cell.textLabel!.text = circles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        println("inside")
        return true
    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            circles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            println("123")
        } else {
            println("Unhandled editing style!")
        }
    }
}
