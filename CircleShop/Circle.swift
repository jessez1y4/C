import Foundation

class Circle : PFObject, PFSubclassing {
    
    @NSManaged var name: String
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Circle"
    }
    
    func getItems(page: Int, per: Int, callback: ([Item]!, NSError!) -> Void) -> Int {
        let q = Item.query()
        
        q.whereKey("circle", equalTo: self)
        q.orderByDescending("createdAt")
        q.limit = per
        q.skip = per * page
        
        q.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            callback(results as? [Item], error)
        }
        
        return page + 1
    }
}