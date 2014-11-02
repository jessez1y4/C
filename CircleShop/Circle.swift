import Foundation

class Circle : PFObject, PFSubclassing {
    
    @NSManaged var name: String
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Circle"
    }
    
    func getItems(page: Int, callback: PFArrayResultBlock) {
        let q = Item.query()
        
        q.whereKey("circle", equalTo: self)
        q.skip = 10 * page
        q.limit = 10
        
        q.findObjectsInBackgroundWithBlock(callback)
    }
}