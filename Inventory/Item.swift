//
//  Item.swift
//  Inventory
//
//  Created by Alex Retter on 2/29/16.
//  Copyright © 2016 ReGroup. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    init(name:String, valueInDollars: Int, serialNumber: String?, dateCreated: NSDate) {
        
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Cheese"]
            
            var idx = arc4random_uniform(UInt32(nouns.count))
            let randomAdjective = adjectives[Int(idx)]
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init (name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber, dateCreated: NSDate())
                
            
        } else {
            self.init(name: "", valueInDollars: 0,  serialNumber: nil, dateCreated: NSDate())
        }
    
    
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
    }
    
    required init(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObjectForKey("name") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String
        valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars")
        
        super.init()
        
    }

}