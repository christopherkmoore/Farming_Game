//
//  Inventory.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/10/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

enum InventoryError: Swift.Error {
    case insufficientStock(amountNeeded: Int)
}

class Inventory {
    
    public static let shared = Inventory()
    
    private var gold: Int = 100
    private var plots: [Plot] = []
    public static let goldNotificationKey = "goldChanged"
    
    public var totalItem: Int {
        return items.count
    }
    
    public var totalGold: Int {
        return gold
    }
    
    // TODO: need to make class for all the items and func for returning all of them
    private var items: [Item: Int] = [:]
    
    init() {
        for _ in 0...4 {
            plots.append(Plot())
        }
    }
    
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
    
    public func add(gold: Int, removing item: Item, count: Int, with delegate: InventoryChange? = nil, updating viewController: UIViewController? = nil) {
        self.gold += gold
        
        try? decrease(item: item, count: count)
        
        if let delegate = delegate,
            let viewController = viewController {
            
         delegate.inventoryDidChange(sender: viewController)
        }
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

    public func decrease(item: Item, count: Int) throws {

        guard let itemCount = items[item],
            itemCount >= count else {
                return
        }
        
        let newTotal = itemCount - count
        if newTotal < 0 {
            // should probably throw error
            throw InventoryError.insufficientStock(amountNeeded: newTotal)
        }
        
        if newTotal == 0 {
            items.removeValue(forKey: item)
        } else {
            items[item]? = newTotal
        }
    }
    
    public func count(for item: Item) -> Int {
        return items[item] ?? 0
    }

    
}
