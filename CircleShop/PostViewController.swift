//
//  PostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/16/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, DBCameraViewControllerDelegate {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var nameInput: UITextField!
    
    var image: UIImage!
    var processImageNumber = 0
    
    var imageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView1.image = image
        
        self.imageViews = [imageView1, imageView2, imageView3, imageView4]
    }
    
    
    @IBAction func tapImageGestureRecognized(sender: AnyObject)
    {
        let tapImage = sender as UITapGestureRecognizer
        let view = tapImage.view! as UIImageView
        
        processImageNumber = find(self.imageViews, view)!;
        handleClick(view)
    }
    
    
    func handleClick(imageView: UIImageView){
        if imageView.image != nil {
            println("not empty!")
            
            // show the alert and probally delete the image
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            let cameraController = DBCameraViewController.initWithDelegate(self)
            cameraController.setForceQuadCrop(true)
            
            let container = DBCameraContainerViewController(delegate: self)
            container.setDBCameraViewController(cameraController)
            
            let nav = UINavigationController(rootViewController: container)
            nav.setNavigationBarHidden(true, animated: true)
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func postBtnClicked(sender: AnyObject) {
        var itemImages: [PFFile] = []
        
        for imageView in self.imageViews {
            if let image = imageView.image {
                let imageData = UIImageJPEGRepresentation(image, 0.9)
                let imageFile = PFFile(name:"image.jpg", data:imageData)
                
                itemImages.append(imageFile)
            }
        }
        
        var user = PFUser.currentUser()

        let item = PFObject(className: "Item", dictionary: [
            "name": self.nameInput.text,
            "images": itemImages,
            "user": user
            ])
        
        item.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            println("item saved")
        }
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        
        self.imageViews[processImageNumber].image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
