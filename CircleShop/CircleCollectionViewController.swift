//
//  CircleCollectionViewController.swift
//  CircleShop
//
//  Created by yue zheng on 10/20/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class CircleCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var objects: [PFObject] = []
    var isRefreshing = true
    var startContentOffset: CGFloat = 0
    var lastContentOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var logoImage = UIImage(named: "bicon.png")
        var backCircleImage = UIImage(named: "light_circle.png")
        var frontCircleImage = UIImage(named: "dark_circle.png")
        
        var progressView = BMYCircularProgressView(frame: CGRectMake(0, 0, 25, 25), logo: logoImage, backCircleImage: backCircleImage, frontCircleImage: frontCircleImage)
        
        self.collectionView.setPullToRefreshWithHeight(60, actionHandler: { (pullToRefreshView: BMYPullToRefreshView!) -> Void in

//            var delayInSeconds: Int64 = 1
//            var popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
//            
//            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
//                
//                println("haha")
//                pullToRefreshView.stopAnimating()
//
//            })
            
            println("haha")
            pullToRefreshView.stopAnimating()
        })
        
        self.collectionView.pullToRefreshView.setProgressView(progressView)
        
        
        self.performQuery()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_detail") {
            let destViewController = segue.destinationViewController as DetailViewController
        }
    }
    
    func performQuery() {
        
        let query = PFQuery(className: "Item")
        
//        if isRefreshing {
//            query.skip = self.objects.count
//        }
        
        query.findObjectsInBackgroundWithBlock { (items, error) -> Void in
            if error == nil {
                self.objects = items as [PFObject]
                self.collectionView.reloadData()
            }
     
        }



    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return self.collectionView(collectionView, cellForItemAtIndexPath: indexPath, object : self.objects[indexPath.row])
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, object : PFObject!) -> UICollectionViewCell {
        
        var cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CircleCollectionCell", forIndexPath: indexPath) as CircleCollectionViewCell

        cell.imageView.file = (object["images"] as [PFFile])[0]
        cell.imageView.loadInBackground(nil)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // down to the bottom
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge >= scrollView.contentSize.height {
                self.performQuery()
        }

    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        lastContentOffset = scrollView.contentOffset.y
        startContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentOffset = scrollView.contentOffset.y
        var differenceFromStart = startContentOffset - currentOffset
        var differenceFromLast = lastContentOffset - currentOffset
        lastContentOffset = currentOffset
        
        if((differenceFromStart) < 0)
        {
            // scroll up
            println("scroll up")
        }
        else {
            println("scroll down")

        }
    }




}
