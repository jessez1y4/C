//
//  Circle.swift
//  CircleShop
//
//  Created by Yu Jiang on 9/28/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import Foundation

class Circle {
    var name: String
    var longitude: Float
    var latitude: Float
    
    init(name: String, longitude: Float, latitude: Float) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init(dict: NSMutableDictionary) {
        self.name = dict.objectForKey("name")! as String
        self.longitude = dict.objectForKey("longitude")! as Float
        self.latitude = dict.objectForKey("latitude")! as Float
    }
    
    func toNSMutableDict() -> NSMutableDictionary {
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        dict.setValue(self.name, forKey: "name")
        dict.setValue(self.longitude, forKey: "longitude")
        dict.setValue(self.latitude, forKey: "latitude")
        
        return dict;
    }
    
    func toDict() -> [String: String] {
        return [
            "name": self.name,
            "longitude": "\(self.longitude)",
            "latitue": "\(self.latitude)"
        ]
    }
}