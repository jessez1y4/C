//
//  ScrollTableViewCell.swift
//  CircleShop
//
//  Created by yue zheng on 12/1/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class ScrollTableViewCell: PFTableViewCell {
    //    var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}