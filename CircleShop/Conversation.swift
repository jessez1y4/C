import Foundation

class Conversation : PFObject, PFSubclassing {
    
    @NSManaged var user1: User
    @NSManaged var user2: User
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Conversation"
    }
    
    func getOtherUser() -> User {
        if User.currentUser().objectId == self.user1.objectId {
            return user2
        } else {
            return user1
        }
    }
    
    func getMessages(callback: ([Message]!, NSError!) -> Void) {
        let q = Message.query()
        
        q.whereKey("conversation", equalTo: self)
        q.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if let messages = results as? [Message] {
                callback(messages, nil)
            } else {
                callback(nil, error)
            }
        }
    }
}