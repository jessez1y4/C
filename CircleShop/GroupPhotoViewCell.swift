//
//  PostViewCell.swift
//  CircleShop
//
//  Created by yue zheng on 9/14/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit
import AssetsLibrary


class GroupPhotoViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var albumTitle: UILabel!
    
    var assetsGroup : ALAssetsGroup!
    
    
    func applyData(assetsGroup: ALAssetsGroup){
        self.assetsGroup = assetsGroup
        //
        //        var posterImage     = assetsGroup.posterImage();
        //        var height        = CGImageGetHeight(posterImage)
        //        var scale           = CGFloat(1)
        //
        var albumTitleNumber = String(assetsGroup.numberOfAssets())
        var albumTitleString = assetsGroup.valueForProperty(ALAssetsGroupPropertyName) as String
        albumTitleString = albumTitleString + " (" + albumTitleNumber + ")"
        
        self.albumImageView.image = UIImage(CGImage: assetsGroup.posterImage().takeUnretainedValue())
        self.albumTitle.text      = albumTitleString
        //    self.accessoryType          = UITableViewCellAccessoryDisclosureIndicator;
    }
}
