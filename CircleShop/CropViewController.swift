//
//  PostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/15/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class CropViewController: BASSquareCropperViewController, BASSquareCropperDelegate {
    
    var image: UIImage!
    
    override func viewDidLoad() {
        
        self.navigationController!.setNavigationBarHidden(true, animated: true)
        
        super.setWithImage(self.image, minimumCroppedImageSideLength: CGFloat(400.0))
        
        self.squareCropperDelegate = self;
        self.excludedBackgroundColor = UIColor.blackColor()
        self.backgroundColor = UIColor.blackColor()
        self.borderColor = UIColor.whiteColor()
        
        super.viewDidLoad()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_post") {
            let destViewController = segue.destinationViewController as PostViewController
            destViewController.image = self.image
        }
    }
    
    
    
    func squareCropperDidCancelCropInCropper(cropper: BASSquareCropperViewController!) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func squareCropperDidCropImage(croppedImage: UIImage!, inCropper cropper: BASSquareCropperViewController!) {
        self.image = croppedImage
        self.performSegueWithIdentifier("show_post", sender: self)
    }

}
