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


protocol Item {
    
    static var time: Double { get }
    static var accessibilityName: String { get }
    static var minPrice: Int { get }
    static var maxPrice: Int { get }
    
    func increase(count: Int)
    func decrease(count: Int)
}

extension Item {
    
    // MARK: - API for incrementing and decrementing total <T>
    
    public func increase(count: Int) {
        Inventory.shared.add(item: Self.accessibilityName, count: count)
    }
    
    public func decrease(count: Int) {
        Inventory.shared.decrease(item: Self.accessibilityName, count: count)
    }
    
    
}


