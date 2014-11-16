//
//  ScrollTableViewCell.swift
//  CircleShop
//
//  Created by yue zheng on 11/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class ScrollTableViewCell: PFTableViewCell {
    var scrollView: UIScrollView!
    var imgView1: UIImageView!
    var imgView2: UIImageView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize() {
        var frame = CGRectMake(0, 0, 320, 320)
        scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(2 * scrollView.bounds.width, scrollView.bounds.height)
        var viewSize = scrollView.bounds
        imgView1 = UIImageView(frame: viewSize)
        scrollView.addSubview(imgView1)
        
        viewSize = CGRectOffset(viewSize, scrollView.bounds.width, 0)
        imgView2 = UIImageView(frame: viewSize)
        scrollView.addSubview(imgView2)
        self.contentView.addSubview(scrollView)
        
    }

    
}
