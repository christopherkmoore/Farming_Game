
//
//  PlotsViewModel.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

class PlotsViewModel {
    
    public func numberOfCells() -> Int {
        return Inventory.shared.totalPlots
    }
    
    public func plot(at index: Int) -> Plot? {
        guard index <= Inventory.shared.totalPlots else {
            print("Index out of bounds")
            return nil
        }
        
        return try? Inventory.shared.plot(at: index)
    }
}
