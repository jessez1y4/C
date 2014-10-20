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
    
    
    class func getCircles() -> [Circle]? {
        if let dictArr = NSUserDefaults.standardUserDefaults().arrayForKey("circles") as? [NSMutableDictionary] {
            return dictArr.map {
                (var dict) -> Circle in
                return Circle(dict: dict)
            }
        }
        
        return nil
    }
    
    class func setCircles(circles: [Circle]) {
        let circleArr = NSMutableArray()
        
        for circle in circles {
            circleArr.addObject(circle.toNSMutableDict())
        }
        
        NSUserDefaults.standardUserDefaults().setObject(circleArr, forKey: "circles")
        
        var params = self.getBaseParams()
        params["circles"] = circles.map {
            (var circle) -> [String: String] in
            return circle.toDict()
        }
        
        // sync with server
        Helpers.AFManager().POST(UPDATE_CIRCLES_URL, parameters: params, success: nil, failure: nil)
    }
    
    class func updateItem(item: Item, callback: (updated: Bool) -> Void) {
        var params = self.getBaseParams()
        params["item"] = item.toDict()
        
        Helpers.AFManager().POST(UPDATE_ITEM_URL, parameters: params, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
            callback(updated: true)
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                callback(updated: false)
                
        })
    }
    
    
    class func sendMessage(receiver: User) {
        
    }
    
    
    private class func getBaseParams() -> [String: AnyObject] {
        let email = NSUserDefaults.standardUserDefaults().objectForKey("email")! as String
        
        return [
            "email": email,
            "password": SSKeychain.passwordForService(KEYCHAIN_SERVICE, account: email)
        ]
    }
}