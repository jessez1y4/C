import Foundation

class Message : PFObject, PFSubclassing, JSQMessageData {
    
    @NSManaged var content: String
    @NSManaged var unread: Bool
    @NSManaged var receiver: User
    @NSManaged var sender: User
    @NSManaged var conversation: Conversation
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Message"
    }
    
    func senderId() -> String! {
        return sender.objectId
    }
    
    func senderDisplayName() -> String! {
        return sender.name
    }
    
    func date() -> NSDate! {
        return self.createdAt
    }
    
    func isMediaMessage() -> Bool {
        return false
    }
    
    func text() -> String! {
        return self.content
    }
}