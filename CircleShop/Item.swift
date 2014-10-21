
import Foundation

class Item {
    var id: String?
    var name: String
    var description: String
    var images: [String]
    var price: Int
    var user: User?
    
    /**
    Initilize an instance with a dictionary
    
    :param: dict dictionary containing the values
    
    :returns: an instance of Item
    */
    init(dict: [String: AnyObject]) {
        if let id: AnyObject = dict["_id"] {
            self.id = id as? String
        }
        
        self.name = dict["name"]! as String
        self.description = dict["description"]! as String
        self.images = dict["images"]! as [String]
        self.price = dict["price"]! as Int
    }
    
    /**
    Initilize an instance with separate attributes
    
    :param: id          id
    :param: name        name
    :param: description description
    :param: images      images
    :param: price       price
    
    :returns: an instance of Item
    */
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
    :param: callback callback function when server responds
    */
    class func fetchOne(id: String, callback: (item: Item?) -> Void) {
        Helpers.AFManager(true).GET("\(ITEM_BASE_URL)\(id)", parameters: nil, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
            let dict = responseObject as [String: AnyObject]
            callback(item: Item(dict: dict))
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                callback(item: nil)
                
        })
    }
    
    /**
    Fetch a list of items from server by condition
    
    :param: condition condition to filter items
    :param: callback  callback function when server responds
    */
    class func fetch(condition: [String: AnyObject], callback: (items: [Item]?) -> Void) {
        let params = ["condition": condition]
        
        Helpers.AFManager(true).GET(ITEMS_URL, parameters: params, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            
            let dicts = responseObject as [[String: AnyObject]]
            let items = dicts.map {
                (var dict) -> Item in
                return Item(dict: dict)
            }
            
            callback(items: items)
            
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
