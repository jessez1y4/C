//
//  CircleTabBarController.swift
//  CircleShop
//
//  Created by yue zheng on 10/1/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class CircleTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var circleView = PostViewController()
        circleView.tabBarItem = UITabBarItem(title: "Circle", image: nil, tag: 0)
        
        self.viewControllers = [circleView]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    private func addCenterButtonWithImage(buttonImage:UIImage, highlightImage:UIImage) -> Void {
//        var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        
//        button.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleTopMargin
//        
//        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
//        
//        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
//        
//        button.setBackgroundImage(highlightImage, forState:UIControlState.Highlighted)
//
//        var heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//
//        if(heightDifference < 0){
//            button.center = self.tabBar.center
//        }
//        else{
//            var center = self.tabBar.center;
//            center.y = center.y - heightDifference/2.0;
//            button.center = center;
//        }
//        
//        self.view.addSubview(button)
//    }
//    
//    func willAppearIn(navigationController: UINavigationController){
//        
//    }

    



}
