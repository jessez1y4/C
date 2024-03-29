import UIKit

var _AFManager: AFHTTPRequestOperationManager?

class Helpers {
    // Show simple alert with a close button
    class func showSimpleAlert(viewController: UIViewController, title: String = "", message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}