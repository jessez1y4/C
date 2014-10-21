//
//  AppDelegate.swift
//  CircleShop
//
//  Created by yue zheng on 8/31/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate, DBCameraViewControllerDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        let tabController = self.window!.rootViewController as UITabBarController
        tabController.delegate = self
        
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        
        let postViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostId") as PostViewController
        
        postViewController.image = image
        
        cameraViewController.restoreFullScreenMode
        cameraViewController.navigationController!?.pushViewController(postViewController, animated: true)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.window!.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if(User.isLoggedIn()) {
            
            if(viewController.title == "Post"){
                
                let cameraController = DBCameraViewController.initWithDelegate(self)
                cameraController.setForceQuadCrop(true)
                
                let container = DBCameraContainerViewController(delegate: self)
                container.setDBCameraViewController(cameraController)
                
                let nav = UINavigationController(rootViewController: container)
                nav.setNavigationBarHidden(true, animated: true)
                
                self.window!.rootViewController?.presentViewController(nav, animated: true, completion: nil)
                
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            if(viewController.title != "Circle"){
                
                let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginId") as UIViewController
                
                self.window!.rootViewController?.presentViewController(loginController, animated: true, completion: nil)
                
                return false
            }
            else{
                return true
            }
        }
        
    }
}

