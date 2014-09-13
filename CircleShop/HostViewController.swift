//
//  HostViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class HostViewController: ViewPagerController, ViewPagerDataSource, ViewPagerDelegate {
    
    var numberOfTab: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self;
        self.delegate = self;
    }
    
    
    
    //pragma mark - ViewPagerDataSource
    func numberOfTabsForViewPager(viewPager: ViewPagerController!) -> UInt {
        return 5
    }
    
    
    
    func viewPager(viewPager: ViewPagerController!, contentViewControllerForTabAtIndex index: UInt) -> UIViewController! {
        var cvc: AnyObject! = self.storyboard.instantiateViewControllerWithIdentifier("CircleViewControllerId")
        
        return cvc as UIViewController
    }
    
    
    func viewPager(viewPager: ViewPagerController!, viewForTabAtIndex index: UInt) -> UIView! {
        //        UILabel *label = [UILabel new];
        //        label.backgroundColor = [UIColor clearColor];
        //        label.font = [UIFont systemFontOfSize:12.0];
        //        label.text = [NSString stringWithFormat:@"Tab #%i", index];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        label.textColor = [UIColor blackColor];
        //        [label sizeToFit];
        var label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.text = "Tabe \(index)"
        label.sizeToFit()
        return UILabel()
    }
    
    
    func viewPager(viewPager: ViewPagerController!, valueForOption option: ViewPagerOption, withDefault value: CGFloat) -> CGFloat {
        //        switch (option) {
        //        case ViewPagerOptionStartFromSecondTab:
        //            return 0.0;
        //        case ViewPagerOptionCenterCurrentTab:
        //            return 1.0;
        //        case ViewPagerOptionTabLocation:
        //            return 0.0;
        //        case ViewPagerOptionTabHeight:
        //            return 49.0;
        //        case ViewPagerOptionTabOffset:
        //            return 36.0;
        //        case ViewPagerOptionTabWidth:
        //            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        //        case ViewPagerOptionFixFormerTabsPositions:
        //            return 1.0;
        //        case ViewPagerOptionFixLatterTabsPositions:
        //            return 1.0;
        //        default:
        //            return value;
        return 1.0
    }
    
    
    func viewPager(viewPager: ViewPagerController!, colorForComponent component: ViewPagerComponent, withDefault color: UIColor!) -> UIColor! {
        //        switch (component) {
        //        case ViewPagerIndicator:
        //            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        //        case ViewPagerTabsView:
        //            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        //        case ViewPagerContent:
        //            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        //        default:
        //            return color;
        return UIColor.redColor()
    }
    
    func viewPager(viewPager: ViewPagerController!, didChangeTabToIndex index: UInt) {
        
    }

}
