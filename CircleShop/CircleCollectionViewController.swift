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
    
    var objects:[PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // do some query..
        objects = []

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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath, object : PFObject) -> UICollectionViewCell {
        
        var cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CircleCollectionCell", forIndexPath: indexPath) as CircleCollectionViewCell
        
//        cell.imageView.file = object["itemImages"][0] as PFFile
        
        return cell
    }

}
