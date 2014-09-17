//
//  Helpers.swift
//  CircleShop
//
//  Created by Jiang, Yu on 6/7/14.
//  Copyright (c) 2014 TBD. All rights reserved.
//

import UIKit

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
}