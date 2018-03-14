//
//  Item.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/8/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation


/* this is super rough but essentially this protocol
should define required properties of a "Fruit" or "Vegetable"
or whatever
 */


public class Food: Item {
    let time: Double
    
    init(time: Double, name: String, minPrice: Int, maxPrice: Int) {
        self.time = time
        
        super.init(name: name, minPrice: minPrice, maxPrice: maxPrice)
    }
    
}

public class Item: InventoryManageable {
    
    let name: String
    let minPrice: Int
    let maxPrice: Int
    
    init( name: String, minPrice: Int, maxPrice: Int) {
        self.name = name
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
   
}

extension Item: Hashable {
    
    public var hashValue: Int {
        return name.hashValue
    }

    public static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}


public protocol InventoryManageable {
    
    static func increase(item: Item, by count: Int)
    static func decrease(item: Item, by count: Int)
}

extension InventoryManageable {
    
    // MARK: - API for incrementing and decrementing total <T>
    
    public static func increase(item: Item, by count: Int) {
        Inventory.shared.add(item: item, count: count)
    }
    
    public static func decrease(item: Item, by count: Int) {
        try? Inventory.shared.decrease(item: item, count: count)
    }

}


