//
//  HostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

var tabNumber: UInt!
var currentTabNumber: UInt!
var newCircleNameArray: [String] = []

class HostViewController: ViewPagerController, ViewPagerDataSource, ViewPagerDelegate {
    
    var numberOfTab: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabNumber = 2
        currentTabNumber = tabNumber
        self.dataSource = self
        self.delegate = self
    }
    
//    override func viewWillAppear(animated: Bool) {
//        self.tabBarController!.tabBar.backgroundColor = UIColor.blueColor()
//    }
    
    
    
    //pragma mark - ViewPagerDataSource
    func numberOfTabsForViewPager(viewPager: ViewPagerController!) -> UInt {
        return tabNumber
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, contentViewControllerForTabAtIndex index: UInt) -> UIViewController! {
        
        // change the dataSrouce here
        
        var cvc: AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("CircleViewControllerId")
        
        return cvc as UIViewController
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, viewForTabAtIndex index: UInt) -> UIView! {
        var label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.systemFontOfSize(12.0)
        if(currentTabNumber < tabNumber){
            label.text = newCircleNameArray[tabNumber-currentTabNumber-1]
            currentTabNumber = tabNumber
        }else{
            label.text = "Tab \(index)"
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
    
    
    @IBAction func addCircle(sender: AnyObject) {
    }
    
    
    @IBAction func click(sender: AnyObject) {
        tabNumber = tabNumber + 1
        newCircleNameArray.append("newadded")
        self.reloadData()
    }
    

}
