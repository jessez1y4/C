import Foundation

class CurrentUser {
    
    class func logOut() {
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let email = standardUserDefaults.objectForKey("email") as? String {
            standardUserDefaults.removeObjectForKey("email")
            SSKeychain.deletePasswordForService(KEYCHAIN_SERVICE, account: email)
        }
    }
    
    class func getEmail() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("email") as? String
    }
    
    class func getId() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("id") as? String
    }
    
    class func getName() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
    }
    
    class func getAvatar() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("avatar") as? String
    }
    
    class func addCircle(name: String, location: CLLocation, callback: PFBooleanResultBlock) {
        let circle = PFObject(className: "Circle", dictionary: [
            "name": name,
            "location": location,
            "user": PFUser.currentUser()
            ])
        
        circle.saveInBackgroundWithBlock(callback)
    }
    
    class func removeCircle(circle: PFObject) {
        circle.deleteEventually()
    }
    
    
    class func getCircles(callback: PFArrayResultBlock) {
        let query = PFQuery(className: "Circle")
        
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        query.whereKey("user", equalTo: PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock(callback)
    }
    
//    class func setCircles(circles: [Circle]) {
//        let circleArr = NSMutableArray()
//        
//        for circle in circles {
//            circleArr.addObject(circle.toNSMutableDict())
//        }
//        
//        NSUserDefaults.standardUserDefaults().setObject(circleArr, forKey: "circles")
//        
//        let params = ["circles": circles.map {
//            (var circle) -> [String: String] in
//            return circle.toDict()
//        }]
//        
//        // sync with server
//        Helpers.AFManager(true).POST(CIRCLES_URL, parameters: params, success: nil, failure: nil)
//    }
    
    class func updateItem(item: Item, callback: (updated: Bool) -> Void) {
        let params = ["item": item.toDict()]
        
        Helpers.AFManager(true).PUT("\(ITEM_BASE_URL)\(item.id)", parameters: params, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
            callback(updated: true)
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                callback(updated: false)
                
        })
    }
    
    
    class func sendMessage(receiver: User) {
        
    }
}