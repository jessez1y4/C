//
//  PhotoCollectionViewCell.swift
//  CircleShop
//
//  Created by yue zheng on 9/14/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIkit
import AssetsLibrary

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func applyData(asset: ALAsset){
        let scale: CGFloat = CGFloat(asset.defaultRepresentation().scale())
        //        var orientation: UIImageOrientation = UIImageOrientation.Up
        //        var orientationValue: AnyObject! = asset.valueForProperty("ALAssetPropertyOrientation")
        //        if (orientationValue != nil) {
        //            orientation = orientationValue.intValue()
        //        }
        
        self.imageView.image = UIImage(CGImage: asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue(), scale: scale, orientation: UIImageOrientation.Up)
    }
    
}
