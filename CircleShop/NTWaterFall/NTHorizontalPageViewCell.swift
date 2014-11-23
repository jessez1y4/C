//
//  NTHorizontalPageViewCell.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 7/1/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import Foundation
import UIKit

let cellIdentify = "cellIdentify"

class NTTableViewCell : PFTableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel.font = UIFont.systemFontOfSize(13)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.imageView.image != nil {
            self.imageView.frame = CGRectMake(0, 0, screenWidth, screenWidth)
        }
    }
}

class NTHorizontalPageViewCell : UICollectionViewCell, UITableViewDelegate, UITableViewDataSource{
    var scrollView: UIScrollView!
    var imageFiles : [PFFile]?
    var pullAction : ((offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: screenBounds, style: UITableViewStyle.Plain)
    var placeholder = UIImage(named: "bicon.png")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        
        contentView.addSubview(tableView)
        tableView.registerClass(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tableView.registerClass(ScrollTableViewCell.self, forCellReuseIdentifier: "ScrollCell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        if scrollView == nil {
            var frame = CGRectMake(0, 0, 320, 320)
            scrollView = UIScrollView(frame: frame)
            scrollView.backgroundColor = UIColor.clearColor()
            scrollView.pagingEnabled = true
        }
        super.layoutSubviews()
        tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ScrollCell") as ScrollTableViewCell!
            var imageCount = CGFloat(imageFiles!.count)


            scrollView.contentSize = CGSizeMake(imageCount * scrollView.bounds.width, scrollView.bounds.height)
            var viewSize = scrollView.bounds
            var imgView = PFImageView(frame: viewSize)
            imgView.file = imageFiles![0]
            scrollView.addSubview(imgView)
            imgView.loadInBackground(nil)
            
            for(var i = 1; i < imageFiles!.count; i++){
                viewSize = CGRectOffset(viewSize, scrollView.bounds.width, 0)
                var imgView = PFImageView(frame: viewSize)
                imgView.file = imageFiles![i]
                scrollView.addSubview(imgView)
                imgView.loadInBackground(nil)
            }

            cell.contentView.addSubview(scrollView)
            cell.setNeedsLayout()
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") as DetailTableViewCell!
            cell.textLabel.text = "try pull to pop view controller 😃"
            cell.setNeedsLayout()
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var cellHeight : CGFloat = navigationHeight
//        if indexPath.row == 0{
            cellHeight = screenWidth
//        }

        return cellHeight
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(scrollView : UIScrollView){
        if scrollView.contentOffset.y < navigationHeight{
            pullAction?(offset: scrollView.contentOffset)
        }
    }
}