//
//  InventoryTimerManager.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/11/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

class InventoryTimerManager {
    
    public static let shared = InventoryTimerManager()
        
    public func grow(food: Food, completion: @escaping(_ success: Bool) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + food.time) {
            completion(true)
        }
        completion(false)
    }
}
