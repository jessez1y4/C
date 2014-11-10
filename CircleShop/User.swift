import Foundation

class User : PFUser {
    
    @NSManaged var name: String
    @NSManaged var circle: Circle
    
    override class func load() {
        self.registerSubclass()
    }
    
    override class func currentUser() -> User! {
        return super.currentUser() as User!
    }
    
    class func getItems(callback: ([Item]!, NSError!) -> Void) {
        let q = Item.query()
        
        q.whereKey("user", equalTo: self)
        
        q.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            callback(results as? [Item], error)
        }
    }
    
    class func getConversations(callback: ([Conversation]!, NSError!) -> Void) {
        let user = User.currentUser()
        let querys = [Conversation.query(), Conversation.query()]
        querys[0].whereKey("userA", equalTo: user)
        querys[1].whereKey("userB", equalTo: user)
        
        Async.mapParallel(querys, mapFunction: { (qurey, success, fail) -> Void in
            (qurey as PFQuery).findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                if let conversations = results {
                    success(conversations)
                } else {
                    fail(error)
                }
            })
            }, success: { (conversations) -> Void in
                callback(conversations as [Conversation], nil)
            }) { (error) -> Void in
                callback(nil, error)
        }
    }

}