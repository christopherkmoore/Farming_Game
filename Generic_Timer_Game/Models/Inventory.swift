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
    
    private var gold: Int = 100
    
    public var totalItem: Int {
        return items.count
    }
    
    public var totalGold: Int {
        return gold
    }
    
    // TODO: need to make class for all the items and func for returning all of them
    private var items: [Item: Int] = [:]
    
    public func add(item: Item, count: Int) {

        // holy hacky
        if let _ = items[item] {
            items[item]? += count
        } else {
            items[item] = 1
        }

    }
    
    public func add(gold: Int) {
        self.gold += gold
    }
    
    public func remove(gold: Int) {
        self.gold -= gold
    }

    public func item(at index: Int) -> (item: Item, count: String)? {

        let array = Array(items.keys)

        let item = array[index]

        guard let value = items[item] else {
            return nil
        }

        let count = String(describing: value)
        return (item, count)

    }

    public func decrease(item: Item, count: Int) {

        guard let itemCount = items[item],
            itemCount > count else {
                return
        }

        items[item]? -= count
    }
    
    public func count(for item: Item) -> Int {
        return items[item] ?? 0
    }
    
    
}
