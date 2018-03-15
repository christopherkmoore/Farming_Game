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
        
    public func grow(seed: Seed, completion: @escaping(_ success: Bool) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + seed.growTime) {
            completion(true)
        }
        completion(false)
    }
}
