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

class NTTableViewCell : UITableViewCell{
    
    var pfImageView : PFImageView = PFImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel.font = UIFont.systemFontOfSize(13)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pfImageView.frame = CGRectZero
        if (pfImageView.image != nil) {
            let imageHeight = pfImageView.image!.size.height*screenWidth/pfImageView.image!.size.width
            pfImageView.frame = CGRectMake(0, 0, screenWidth, imageHeight)
        }
    }
}

class NTHorizontalPageViewCell : UICollectionViewCell, UITableViewDelegate, UITableViewDataSource{
    var imageFile : PFFile?
    var pullAction : ((offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: screenBounds, style: UITableViewStyle.Plain)
    var placeholder = UIImage(named: "bicon.png")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        
        contentView.addSubview(tableView)
        tableView.registerClass(NTTableViewCell.self, forCellReuseIdentifier: cellIdentify)
        tableView.delegate = self
        tableView.dataSource = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as NTTableViewCell!
//        cell.imageView.image = nil
//        cell.textLabel.text = nil
        if indexPath.row == 0 {
            cell.pfImageView.image = self.placeholder
            cell.pfImageView.file = imageFile
            cell.pfImageView.loadInBackground(nil)
            
//            let image = UIImage(named: imageName!)
//            cell.imageView.image = image
        }else{
            cell.textLabel.text = "try pull to pop view controller 😃"
        }
        cell.setNeedsLayout()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var cellHeight : CGFloat = navigationHeight
        if indexPath.row == 0{
            
            var creature = PFImageView()
            creature.image = self.placeholder
            creature.file = imageFile
            creature.loadInBackground({ (image, error) -> Void in
                let imageHeight = image.size.height*screenWidth/image.size.width
                cellHeight = imageHeight

            })
//            let image:UIImage! = UIImage(named: imageName!)
//            let imageHeight = creature.image!.size.height*screenWidth/creature.image!.size.width
//            cellHeight = imageHeight
            
            
            
//            cellHeight = screenWidth
        }
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