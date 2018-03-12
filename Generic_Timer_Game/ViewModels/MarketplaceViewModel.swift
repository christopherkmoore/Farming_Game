//
//  MarketplaceViewModel.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/10/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

class MarketplaceViewModel {
    
    public func numberOfCells() -> Int {
        return Inventory.shared.totalItem
    }
    
    public func details(at index: Int) -> (name: String, count: String)? {
        guard index < Inventory.shared.totalItem else {
            return nil
        }
        
        return Inventory.shared.item(at: index)
    }
    
    
}
