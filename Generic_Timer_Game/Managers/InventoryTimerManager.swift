//
//  InventoryTimerManager.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/11/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

class InventoryTimerManager {
    
    public static let shared = InventoryTimerManager()
        
    public func increment(food: Food, completion: @escaping(Bool) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + food.time) {
            
            Food.increase(item: food, by: 1)
            completion(true)
        }
        
        completion(false)
    }
    
}
