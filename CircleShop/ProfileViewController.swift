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
        
//        NSArray *array = [self.navigationController viewControllers];
        
//        [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
        self.tabBarController?.navigationController?.popToRootViewControllerAnimated(true)
        
        /* update channels if a different user logs in */
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.channels = ["global"]
        currentInstallation.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println(currentInstallation.channels)
            }
        }
    }
}
