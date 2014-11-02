import Foundation

class Item : PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var desc: String?
    @NSManaged var circle: Circle
    @NSManaged var user: User
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Item"
    }
}