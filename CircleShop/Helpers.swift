import UIKit

var _AFManager: AFHTTPRequestOperationManager?

class Helpers {
    // Show simple alert with a close button
    class func showSimpleAlert(viewController: UIViewController, title: String = "", message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func synced(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
    class func AFManager(withAuthHeader: Bool) -> AFHTTPRequestOperationManager {
        if _AFManager == nil {
            _AFManager = AFHTTPRequestOperationManager()
//            _AFManager?.requestSerializer = AFJSONRequestSerializer()
        }
        
        if withAuthHeader {
            if let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as? NSString {
                let password = SSKeychain.passwordForService(KEYCHAIN_SERVICE, account: email)
                
                _AFManager!.requestSerializer.setValue(email, forHTTPHeaderField: "email")
                _AFManager!.requestSerializer.setValue(password, forHTTPHeaderField: "password")
            }
        }
        
        return _AFManager!
    }
    
    /**
    Generate image url on cloudinary
    
    :param: id     image id on cloudinary
    :param: width  width
    :param: height height
    
    :returns: image url
    */
    class func generateImageURL(id: String, width: Int, height: Int) -> String {
        return "edit me please"
    }
    
    class func shortestDistance(from: PFGeoPoint, tos: [PFGeoPoint]) -> Double {
        var min = Double.infinity
        
        for to in tos {
            let dist = from.distanceInMilesTo(to)
            min = dist < min ? dist : min
        }
        
        return min
    }
    
}