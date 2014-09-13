//
//  FirstViewController.swift
//  CircleShop
//
//  Created by yue zheng on 8/31/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"
let preventcache = Int(arc4random_uniform(10000))

class CircleViewController: UIViewController {
                            
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Circle", style: UIBarButtonItemStyle.Bordered, target: self.navigationController, action:"toggleMenu")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        let num = preventcache + indexPath.row
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as MyCollectionViewCell
        let url = "http://d3lncrho1w0yzl.cloudfront.net/photo1.100x133.2642bytes.webp?\(num)"
        cell.imageView.sd_setImageWithURL(NSURL(string: url))
        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        self.performSegueWithIdentifier("show_detail", sender:self)
        println(indexPath)
        return true
    }
    
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
    return false
    }
    
    func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
    return false
    }
    
    func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
    
    }
    */
    
    
}
