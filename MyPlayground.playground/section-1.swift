// Playground - noun: a place where people can play

import UIKit

var dict = ["ok", "pp"]
    var somehint = dict as NSArray


NSUserDefaults.standardUserDefaults().setObject(somehint, forKey: "testxxs")

NSUserDefaults.standardUserDefaults().synchronize()
NSUserDefaults.standardUserDefaults().objectForKey("testxxxxs") as String
