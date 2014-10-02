//
//  PhotoCollectionViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/14/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit
import AssetsLibrary

class PhotoCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var group: ALAssetsGroup!
    
    var assets : [AnyObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        group.enumerateAssetsWithOptions(NSEnumerationOptions.Reverse, usingBlock: { (asset: ALAsset!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if(asset != nil && asset.valueForProperty(ALAssetPropertyType) as NSString == "ALAssetTypePhoto"){
                //            if(asset != nil){
                self.assets.append(asset)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_crop") {
            let destViewController = segue.destinationViewController as CropViewController
            
            let indexPath = self.collectionView.indexPathForCell(sender as PhotoCollectionViewCell)
            
            destViewController.image = UIImage(CGImage: (self.assets[indexPath!.row] as ALAsset).defaultRepresentation().fullResolutionImage().takeUnretainedValue())
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCollectionCell", forIndexPath: indexPath) as PhotoCollectionViewCell
        // Configure the cell
        cell.applyData(self.assets[indexPath.row] as ALAsset)
        //        var image = self.assets[indexPath.row].
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        println(indexPath)
        return true
    }
    
    
}
