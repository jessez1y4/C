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
    
}