//
//  ProfileViewController.swift
//  CircleShop
//
//  Created by yue zheng on 9/13/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBAction func Logout(sender: AnyObject) {
        User.logOut()
        
        let window = UIApplication.sharedApplication().windows.first as UIWindow
        (window.rootViewController as UINavigationController).popToRootViewControllerAnimated(true)
        
        /* update channels as user logs out */
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.channels = ["global"]
        currentInstallation.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println(currentInstallation.channels)
            }
        }
    }
    
    @IBAction func menuClicked(sender: AnyObject) {
        self.slidingViewController().anchorTopViewToRightAnimated(true)
    }
}
