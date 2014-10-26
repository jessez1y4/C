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

    
    var snapshot: UIView?
    var sourceIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Manage"
                
        var longPress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        self.tableView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // fetch circles
        CurrentUser.getCircles { (circles, error) -> Void in
            self.circles = circles as [PFObject]
            self.tableView.reloadData()
        }
    }
    
    @IBAction func longPressGestureRecognized(sender: AnyObject) {
        var longPress = sender as UILongPressGestureRecognizer
        var state = longPress.state;

        var location = longPress.locationInView(self.tableView)
        var indexPath = self.tableView.indexPathForRowAtPoint(location)
        
        switch (state) {
            case UIGestureRecognizerState.Began:
                // if indexPath exist
                if let _indexPath = indexPath {
                    
                    self.sourceIndexPath = _indexPath
                    
                    var cell = self.tableView.cellForRowAtIndexPath(_indexPath)
                    
                    // Take a snapshot of the selected row using helper method.
                    self.snapshot = self.customSnapshotFromView(cell!)
                    
                    // Add the snapshot as subview, centered at cell's center...
                    var center = cell!.center
                    self.snapshot!.center = center
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
                    var center = self.snapshot!.center
                    center.y = location.y
                    self.snapshot!.center = center
                    
                    // Is destination valid and is it different from source?
                    if (indexPath != nil && indexPath!.isEqual(sourceIndexPath) == false) {
                        
                        // ... update data source.
                        //swap(&circles[indexPath!.row], &circles[sourceIndexPath!.row])
    
                        // ... move the rows.
                        self.tableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: indexPath!)
                        
                        // ... and update source so it is in sync with UI changes.
                        sourceIndexPath = indexPath
                }
        default:
            // Clean up.
            if let _sourceIndexPath = sourceIndexPath {
                
                var cell = self.tableView.cellForRowAtIndexPath(_sourceIndexPath)
            
                if let _cell = cell{
                    
                    _cell.hidden = false
                    _cell.alpha = 0.0
                
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        if let existSnapshot = self.snapshot{
                            existSnapshot.center = _cell.center;
                            existSnapshot.transform = CGAffineTransformIdentity;
                            existSnapshot.alpha = 0.0;
                            
                            // Undo fade out.
                            _cell.alpha = 1.0
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if(segue.identifier == "show_create") {
//            let destViewController = segue.destinationViewController as CreateCircleViewController
//            destViewController.circles = circles
//            
//            //            destViewController.image = self.collectionView.indexPathsForSelectedItems()
//        }
//    }
    
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
            CurrentUser.removeCircle(circles[indexPath.row])
            self.circles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        } else {
            println("Unhandled editing style!")
        }
    }
}
