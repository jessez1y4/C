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
        let geoPoint = PFGeoPoint(location: location)
        
        let circle = PFObject(className: "Circle", dictionary: [
            "name": name,
            "location": geoPoint,
            "user": PFUser.currentUser()
            ])
        
        self.circlesQuery().clearCachedResult()
        circle.saveInBackgroundWithBlock(callback)
    }
    
    class func removeCircle(circle: PFObject) {
        self.circlesQuery().clearCachedResult()
        circle.deleteEventually()
    }
    
    
    class func getCircles(callback: PFArrayResultBlock) {
        self.circlesQuery().findObjectsInBackgroundWithBlock(callback)
    }
    
    class func getNearbyItems(page: Int, callback: PFArrayResultBlock) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if page == 0 {
            userDefaults.removeObjectForKey("nearbyUsers")
        }
        
        if let dict = userDefaults.objectForKey("nearbyUsers") as? [NSString: NSInteger] {
            
            let uids = [NSString](dict.keys) as [String]
            self.getItemsByUsers(page, users: uids, callback: callback)
            
        } else {
            
            self.circlesQuery().findObjectsInBackgroundWithBlock { (userCircles, error) -> Void in
            
                if error == nil {
                    
                    Async.mapParallel(userCircles, mapFunction: { (circle, success, failure) -> Void in
                        let c = circle as PFObject
                        
                        let query = PFQuery(className: "Circle")
                        
                        query.whereKey("location", nearGeoPoint: c["location"] as PFGeoPoint, withinMiles: 5)
                        query.includeKey("user")
                        
                        // TODO sort circles by the date when the latest item was posted in the cirle
                        query.findObjectsInBackgroundWithBlock({ (arr, error) -> Void in
                            if error == nil {
                                success(arr)
                            }
                        })
                        }, success: { (arrArr) -> Void in
                            var users: [NSString:NSInteger] = [:]
                            
                            for arr in arrArr {
                                for circle in (arr as [PFObject]) {
                                    let uid: NSString = (circle["user"] as PFUser).objectId
                                    
                                    users[uid] = 1
                                }
                            }
                            
                            userDefaults.setObject(users, forKey: "nearbyUsers")
                            let uids = [NSString](users.keys) as [String]
                            self.getItemsByUsers(page, users: uids, callback: callback)
                            
                        }, failure: { (error) -> Void in
                            println(error)
                    })
                }
            }
        }
    }
    
    private class func getItemsByUsers(page: Int, users: [String], callback: PFArrayResultBlock) {
        let pfUsers = users.map { (id: String) -> PFUser in
            return PFUser(withoutDataWithObjectId: id)
        }
        
        let q = PFQuery(className: "Item")
        q.whereKey("user", containedIn: pfUsers)
        q.limit = 20
        q.skip = 20 * page
        q.findObjectsInBackgroundWithBlock(callback)
    }
    
    private class func circlesQuery () -> PFQuery {
        let query = PFQuery(className: "Circle")
        
        query.cachePolicy = kPFCachePolicyCacheElseNetwork
        query.whereKey("user", equalTo: PFUser.currentUser())
        
        return query;
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
    
//    class func updateItem(item: Item, callback: (updated: Bool) -> Void) {
//        let params = ["item": item.toDict()]
//        
//        Helpers.AFManager(true).PUT("\(ITEM_BASE_URL)\(item.id)", parameters: params, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
//            
//            callback(updated: true)
//            
//            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                
//                callback(updated: false)
//                
//        })
//    }
    
    
    class func sendMessage(receiver: User) {
        
    }
}