import UIKit


class MyTabBarController: UITabBarController, UITabBarControllerDelegate, DBCameraViewControllerDelegate {
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        
        let postViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PostId") as PostViewController
        
        postViewController.image = image
        
        cameraViewController.restoreFullScreenMode
        cameraViewController.navigationController!?.pushViewController(postViewController, animated: true)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if viewController == tabBarController.viewControllers![1] as UIViewController {
            
            let cameraController = DBCameraViewController.initWithDelegate(self)
            cameraController.setForceQuadCrop(true)
            
            let container = DBCameraContainerViewController(delegate: self)
            container.setDBCameraViewController(cameraController)
            
            let nav = UINavigationController(rootViewController: container)
            nav.setNavigationBarHidden(true, animated: true)
            
            self.presentViewController(nav, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
    
    
    func setTabBarHidden(hidden: Bool, animated: Bool) {
        
        println("setTabBarHidden:%d animated:%d",hidden, animated)
        
        if self.view.subviews.count < 2 {
            return
        }

        var contentView: UIView!
        if self.view.subviews[0].isKindOfClass(UITabBar){
            contentView = self.view.subviews[1] as UIView
        }
        else {
            contentView = self.view.subviews[0] as UIView
        }
        
        if hidden {
            if animated {
                println("HIDDEN - ANIMATED")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    contentView.frame = self.view.bounds
                    self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                    self.view.bounds.size.height,
                    self.view.bounds.size.width,
                    tabbar_height)
                }, completion: { (Bool) -> Void in
                        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                        self.view.bounds.size.height,
                        self.view.bounds.size.width,
                        tabbar_height)
                })
            }
            else {
                println("HIDDEN")
                contentView.frame = self.view.bounds
                self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                self.view.bounds.size.height,
                self.view.bounds.size.width,
                tabbar_height)
            }
            
        }
        else {
            self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
            self.view.bounds.size.height,
            self.view.bounds.size.width,
            0)
            
            if animated {
                println("NOT HIDDEN - ANIMATED")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                    self.view.bounds.size.height - tabbar_height,
                    self.view.bounds.size.width,
                    tabbar_height)
                }, completion: { (Bool) -> Void in
                    contentView.frame = CGRectMake(self.view.bounds.origin.x,
                    self.view.bounds.origin.y,
                    self.view.bounds.size.width,
                    self.view.bounds.size.height - tabbar_height)
                })
            }
            else {
                println("NOT HIDDEN")
                contentView.frame = CGRectMake(self.view.bounds.origin.x,
                self.view.bounds.origin.y,
                self.view.bounds.size.width,
                self.view.bounds.size.height - tabbar_height)
                
                self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                self.view.bounds.size.height - tabbar_height,
                self.view.bounds.size.width,
                tabbar_height)
            }
        }
    }
    
    
}