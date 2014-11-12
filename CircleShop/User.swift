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
    
    func getConversations(callback: ([Conversation]!, NSError!) -> Void) {
        PFCloud.callFunctionInBackground("fetchConversations", withParameters: [:]) { (results, error) -> Void in
            println(results)
            if let conversations = results as? [Conversation] {
                callback(conversations, nil)
            } else {
                callback(nil, error)
            }
        }
    }
}