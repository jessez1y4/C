//
//  NTWaterfallViewCell.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 6/30/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import UIKit

class NTWaterfallViewCell :UICollectionViewCell, NTTansitionWaterfallGridViewProtocol{
    var imageFile : PFFile!
    var imageView: PFImageView = PFImageView()
    var placeholder = UIImage(named: "bicon.png")

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        imageView.image = self.placeholder
        imageView.file = imageFile
        imageView.loadInBackground(nil)
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.imageView.image)
        snapShotView.frame = imageView.frame
        return snapShotView
    }
}