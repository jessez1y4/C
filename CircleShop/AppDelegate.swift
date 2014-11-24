import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        println("executing didFinishLaunchingWithOptions")
            
        Parse.setApplicationId("0ypgutxWtZSQUHtGz1hnx7v9fnQO9X1MDaN0zWMt", clientKey: "nfNfRQNQXQHveTVrvblFtw607Wvpmtbb8s5bD0Ww")
        
        /* go to home if logged in */
        var svc: ECSlidingViewController!
        if User.currentUser() != nil {
            svc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sliding_view_controller") as ECSlidingViewController

            (self.window?.rootViewController as UINavigationController).pushViewController(svc, animated: false)
        }
        
        /* set page control style */
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor();
        
        if launchOptions != nil {
            if let notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
                if let type = notificationPayload.objectForKey("c") as? String {
                    println("this is message")
                    svc.topViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("conversation_nav_controller") as UINavigationController
                }
            }
        }
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["global", PFUser.currentUser().objectId]
        currentInstallation.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println(currentInstallation.channels)
            }
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if let convId = userInfo["c"] as? String {
            if application.applicationState == UIApplicationState.Active {
                /* app already in foreground */
                println("app was already in foreground")
                // TODO update msg count on menu icon?
                // vibrate? sound?
                
                let vc = (self.window?.rootViewController as UINavigationController).topViewController
                if vc.isKindOfClass(ECSlidingViewController) {
                    let nav = (vc as ECSlidingViewController).topViewController as UINavigationController
                    if nav.topViewController.isKindOfClass(MessageViewController) {
                        let mvc = nav.topViewController as MessageViewController
                        let conv = mvc.conversation
                        if conv.objectId == convId {
                            // append msg
                            mvc.reloadMessages()
                            return
                        }
                    }
                }
                
            } else {
                println("app was in background")
                let vc = (self.window?.rootViewController as UINavigationController).topViewController
                if vc.isKindOfClass(ECSlidingViewController) {
                    let nav = (vc as ECSlidingViewController).topViewController as UINavigationController
                    if nav.topViewController.isKindOfClass(MessageViewController) {
                        let mvc = nav.topViewController as MessageViewController
                        let conv = mvc.conversation
                        if conv.objectId == convId {
                            // append msg
                            mvc.reloadMessages()
                            return
                        }
                    }
                    
                    let evc = vc as ECSlidingViewController
                    evc.resetTopViewAnimated(false)
                    evc.topViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("conversation_nav_controller") as UINavigationController
                    return
                }
                
                let svc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sliding_view_controller") as ECSlidingViewController
                (self.window?.rootViewController as UINavigationController).pushViewController(svc, animated: false)
                svc.topViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("conversation_nav_controller") as UINavigationController
            }
        }
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
    
}

