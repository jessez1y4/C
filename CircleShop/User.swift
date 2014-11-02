import Foundation

class User : PFUser {
    
    @NSManaged var name: String
//    @NSManaged var circle: Circle
    
    override class func load() {
        self.registerSubclass()
    }
    
    override class func currentUser() -> User! {
        return super.currentUser() as User!
    }
    
    class func getItems(callback: PFArrayResultBlock) {
        let q = Item.query()
        
        q.whereKey("user", equalTo: self)
        
        q.findObjectsInBackgroundWithBlock(callback)
    }
}