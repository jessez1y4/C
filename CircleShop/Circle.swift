import Foundation

class Circle : PFObject, PFSubclassing {
    
    @NSManaged var name: String
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Circle"
    }
    
    func getItems(page: Int, callback: PFArrayResultBlock) -> Int {
        let q = Item.query()
        
        q.whereKey("circle", equalTo: self)
        q.limit = 6
        q.skip = q.limit * page
        
        q.findObjectsInBackgroundWithBlock(callback)
        
        return page + 1
    }
}