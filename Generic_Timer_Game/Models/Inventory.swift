//
//  Inventory.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/10/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

class Inventory {
    
    public static let shared = Inventory()
    
    var gold: Int = 0
    
    // TODO: need to make class for all the items and func for returning all of them
    private var items: [Item] = [Item]()
    
    public func add(item: String, count: Int) {
       
        // holy hacky
        if let _ = items[item] {
            items[item]? += count
        } else {
            items[item] = 1
        }
        
    }
    public func item(for name: String) -> (name: String, count: String)? {
        guard let count = items[name] else {
            print("no item in inventory: \(name)")
            return nil
        }
        
        let stringCount = String(describing: count)
        
        return (name, stringCount)
    }
    public func item(at index: Int) -> (name: String, count: String)? {
        
        let array = Array(items.keys)
        
        let item = array[index]
        
        guard let value = items[item] else {
            return nil
        }
        
        let count = String(describing: value)
        return (item, count)
        
    }
    
    public func decrease(item: String, count: Int) {
       
        guard let itemCount = items[item],
            itemCount > count else {
                return
        }
        
        items[item]? -= count
    }
    
    public var totalItem: Int {
        return items.count
    }
    
}
