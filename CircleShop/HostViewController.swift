//
//  HostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

var circles: [Circle] = []

class HostViewController: ViewPagerController, ViewPagerDataSource, ViewPagerDelegate {
    
    var numberOfTab: Int!
    var firstTimeEnter: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTimeEnter = true

        self.dataSource = self
        self.delegate = self
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if User.isLoggedIn() {
            
            if firstTimeEnter! {
                circles = CurrentUser.getCircles()!
                firstTimeEnter = false
            
            } else {
                
                CurrentUser.setCircles(circles)
            }
            reloadData()

        }
        
//        self.tabBarController!.tabBar.backgroundColor = UIColor.blueColor()
    }
    
    
    
    //pragma mark - ViewPagerDataSource
    func numberOfTabsForViewPager(viewPager: ViewPagerController!) -> Int {
        return circles.count + 1
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, contentViewControllerForTabAtIndex index: UInt) -> UIViewController! {
        
        // change the dataSrouce here
        
        var cvc: AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("CircleCollectionViewControllerId")
        
        return cvc as UIViewController
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, viewForTabAtIndex index: Int) -> UIView! {
        var label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.systemFontOfSize(12.0)

        if index==0 {
            label.text = "NearBy"
        }
        else {
            label.text = circles[index-1].name
        }
        
        label.textAlignment = NSTextAlignment.Center;
        label.textColor = UIColor.blackColor()
        label.sizeToFit()

        return label
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, valueForOption option: ViewPagerOption, withDefault value: CGFloat) -> CGFloat {
                switch (option) {
                case ViewPagerOption.StartFromSecondTab:
                    return 0.0
                case ViewPagerOption.CenterCurrentTab:
                    return 1.0
                case ViewPagerOption.TabLocation:
                    return 1.0
                case ViewPagerOption.TabHeight:
                    return 39.0
                case ViewPagerOption.TabOffset:
                    return 36.0
                case ViewPagerOption.TabWidth:
                    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0
                case ViewPagerOption.FixFormerTabsPositions:
                    return 1.0
                case ViewPagerOption.FixLatterTabsPositions:
                    return 1.0
                default:
                    return value
        }
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, colorForComponent component: ViewPagerComponent, withDefault color: UIColor!) -> UIColor! {
                switch (component) {
                case ViewPagerComponent.Indicator:
                    return UIColor.redColor().colorWithAlphaComponent(0.64)
                case ViewPagerComponent.TabsView:
                    return UIColor.lightGrayColor().colorWithAlphaComponent(0.32)
                case ViewPagerComponent.Content:
                    return UIColor.darkGrayColor().colorWithAlphaComponent(0.32)
                default:
                    return color;
        }
    }
    
    
    
    
    
    
    
    // ViewPagerDelegate
    func viewPager(viewPager: ViewPagerController!, didChangeTabToIndex index: UInt) {
        println(viewPager.description)
        println(index)
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if segue.identifier == "show_circles" {
//            let destViewController = segue.destinationViewController as ManageCircleViewController
//            destViewController.circles = circles
//        }
//    }
    
    
    @IBAction func addCircle(sender: AnyObject) {
        
    }
    
    
    @IBAction func click(sender: AnyObject) {

    }
    

}
