//
//  PostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/16/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        
        switch(whichImage){
            case 1:
                self.imageView1.image = self.image
            case 2:
                self.imageView2.image = self.image
            case 3:
                self.imageView3.image = self.image
            case 4:
                self.imageView4.image = self.image
            default:
                self.imageView1.image = self.image
        }

    }
    
    @IBAction func tapImageGestureRecognized(sender: AnyObject)
    {
        var tapImage = sender as UITapGestureRecognizer
        
        switch (tapImage.view!) {
            case self.imageView1:
                handleClick(self.imageView1)
                whichImage = 1
            case self.imageView2:
                handleClick(self.imageView2)
                whichImage = 2
            case self.imageView3:
                handleClick(self.imageView3)
                whichImage = 3
            case self.imageView4:
                handleClick(self.imageView4)
                whichImage = 4
        default:
            println("not image found")
            
        }

        
    }
    
    
    func handleClick(imageView: UIImageView){
        if(imageView.image != nil){
            println("not empty!")
            // show the alert and probally delete the image
        }
        else{
            self.performSegueWithIdentifier("show_select", sender: self)
        }
        
    }


}
