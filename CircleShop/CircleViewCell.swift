//
//  CircleViewCell.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class CircleViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
