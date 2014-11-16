import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
       Parse.setApplicationId("0ypgutxWtZSQUHtGz1hnx7v9fnQO9X1MDaN0zWMt", clientKey: "nfNfRQNQXQHveTVrvblFtw607Wvpmtbb8s5bD0Ww")
        
        /* set up push notification */
        if application.respondsToSelector("isRegisteredForRemoteNotifications") {
            // iOS 8 Notifications
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: (.Badge | .Sound | .Alert), categories: nil))
            application.registerForRemoteNotifications()
        } else {
            // iOS < 8 Notifications
            application.registerForRemoteNotificationTypes(.Badge | .Sound | .Alert)
        }

        /* go to home if logged in */
        if User.currentUser() != nil {
            let svc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sliding_view_controller") as ECSlidingViewController

            (self.window?.rootViewController as UINavigationController).pushViewController(svc, animated: false)
        }
        
        /* set page control style */
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor();
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["global"]
        currentInstallation.saveInBackgroundWithBlock(nil)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
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

