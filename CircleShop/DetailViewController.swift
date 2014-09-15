//
//  DetailViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/14/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var image : UIImage!

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
}
