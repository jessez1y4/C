
import Foundation

class Item {
    var id: String?
    var name: String
    var description: String
    var images: [String]
    var price: Int

//    init(dict: [String: AnyObject]) {
////        self.id = dict["_id"] as? String
//        self.name = dict["name"] as String
//        self.description = description
//        self.images = images
//        self.price = price
//    }
    
    init(id: String?, name: String, description: String, images: [String], price: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.images = images
        self.price = price
    }
    
    /**
    Fetch one item from server by id
    
    :param: id       item id
    :param: callback callback function when server responses
    */
    class func fetchOne(id: String, callback: (item: Item?) -> Void) {
        Helpers.AFManager().GET("\(ITEM_BASE_URL)\(id)", parameters: nil, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
                let dict = responseObject as [String: AnyObject]
                let id = dict["_id"]! as String
                let name = dict["name"]! as String
                let description = dict["description"]! as String
                let images = dict["images"]! as [String]
                let price = dict["price"]! as Int
                
                callback(item: Item(id: id, name: name, description: description, images: images, price: price))
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                callback(item: nil)
                
            })
    }
    
    /**
    Fetch a list of items from server by condition
    
    :param: condition condition to filter items
    :param: callback  callback function when server responses
    */
    class func fetch(condition: [String: AnyObject], callback: (items: [Item]?) -> Void) {
        let params = ["condition": condition]
        
        Helpers.AFManager().GET(ITEMS_URL, parameters: params, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
            let dict = responseObject as [String: AnyObject]
            let id = dict["_id"]! as String
            let name = dict["name"]! as String
            let description = dict["description"]! as String
            let images = dict["images"]! as [String]
            let price = dict["price"]! as Int
            
            callback(items: [Item(id: id, name: name, description: description, images: images, price: price)])
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
    
                callback(items: nil)
                
            })
    }
    
    /**
    Parse item to a dictionary that afnetworking can send to server as params
    
    :returns: a dictionary that can be used by afnetworking
    */
    func toDict() -> [String: AnyObject] {
        var dict: [String: AnyObject] = [
            "name": self.name,
            "description": self.description,
            "images": self.images,
            "price": self.price
        ]
        
        if let id = self.id {
            dict["id"] = id
        }
        
        return dict
    }
}
