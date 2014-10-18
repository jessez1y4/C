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
    
    var image: UIImage!
    var processImageNumber = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView1.image = image
        //self.navigationController!.setNavigationBarHidden(false, animated: true)
        
//        switch(whichImage){
//            case 1:
//                self.imageView1.image = self.image
//            case 2:
//                self.imageView2.image = self.image
//            case 3:
//                self.imageView3.image = self.image
//            case 4:
//                self.imageView4.image = self.image
//            default:
//                self.imageView1.image = self.image
//        }

    }
 
    
    @IBAction func tapImageGestureRecognized(sender: AnyObject)
    {
        var tapImage = sender as UITapGestureRecognizer
        
        switch (tapImage.view!) {
            case self.imageView1:
                handleClick(self.imageView1)
                processImageNumber = 1
            case self.imageView2:
                handleClick(self.imageView2)
                processImageNumber = 2
            case self.imageView3:
                handleClick(self.imageView3)
                processImageNumber = 3
            case self.imageView4:
                handleClick(self.imageView4)
                processImageNumber = 4
        default:
            println("not image found")
        }
        
    }
    
    
    func handleClick(imageView: UIImageView){
        if(imageView.image != nil){
            println("not empty!")
            
            // show the alert and probally delete the image
            self.dismissViewControllerAnimated(true, completion: nil)

        }
        else{
            let cameraController = DBCameraViewController.initWithDelegate(self)
            cameraController.setForceQuadCrop(true)
            
            let container = DBCameraContainerViewController(delegate: self)
            container.setDBCameraViewController(cameraController)
            
            let nav = UINavigationController(rootViewController: container)
            nav.setNavigationBarHidden(true, animated: true)
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        
        switch (processImageNumber) {
        case 1:
            self.imageView1.image = image
        case 2:
            self.imageView2.image = image
        case 3:
            self.imageView3.image = image
        case 4:
            self.imageView4.image = image
        default:
            println("not image found")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
