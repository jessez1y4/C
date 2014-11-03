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
    
    var circle = User.currentUser().circle
    var items: [Item] = []
    var page = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var logoImage = UIImage(named: "bicon.png")
        var backCircleImage = UIImage(named: "light_circle.png")
        var frontCircleImage = UIImage(named: "dark_circle.png")
        
        var progressView = BMYCircularProgressView(frame: CGRectMake(0, 0, 25, 25), logo: logoImage, backCircleImage: backCircleImage, frontCircleImage: frontCircleImage)
        
        self.collectionView.setPullToRefreshWithHeight(60, actionHandler: { (pullToRefreshView: BMYPullToRefreshView!) -> Void in

            self.page = self.circle.getItems(0, callback: { (results, error) -> Void in
                if error == nil {
                    println(results)
                    self.items = results as [Item]
                    self.collectionView.reloadData()
                }
                
                pullToRefreshView.stopAnimating()
            })
        })
        
        self.collectionView.pullToRefreshView.setProgressView(progressView)
        
        self.page = self.circle.getItems(0, callback: { (results, error) -> Void in
            if error == nil {
                println(results)
                self.items = results as [Item]
                self.collectionView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_detail") {
            let destViewController = segue.destinationViewController as DetailViewController
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CircleCollectionCell", forIndexPath: indexPath) as CircleCollectionViewCell
        let item = self.items[indexPath.row]

        cell.imageView.file = item.images[0]
        cell.imageView.loadInBackground(nil)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // down to the bottom
        
//        println(scrollView.contentOffset.y)
        
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge > scrollView.contentSize.height + 100 {
            println("xx")
                
            self.page = self.circle.getItems(self.page, callback: { (results, error) -> Void in
                if error == nil {
                    self.items = self.items + (results as [Item])
                    self.collectionView.reloadData()
                }

            })
        }
    }
}
