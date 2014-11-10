import Foundation

class Conversation : PFObject, PFSubclassing {
    
    @NSManaged var userA: User
    @NSManaged var userB: User
    @NSManaged var messages: [Message]
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Conversation"
    }
}