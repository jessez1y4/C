//
//  PostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/16/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        
        self.imageView.image = self.image
    }
}
