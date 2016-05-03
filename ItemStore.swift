//
//  ItemStore.swift
//  Inventory
//
//  Created by Alex Retter on 3/1/16.
//  Copyright © 2016 ReGroup. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        
        let newItem = Item(random: true)
        allItems.append(newItem)

        
        return newItem
    }
    
    init() {
        
        for _ in 0..<5 {
            createItem()
        }

    }



}