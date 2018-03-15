//
//  MarketViewModel.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/14/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

class MarketViewModel {
    
    public func numberOfCells() -> Int {
        return Market.shared.totalSeeds
    }
    
    public func details(at index: Int) -> Seed? {
        guard index < Market.shared.totalSeeds else {
            return nil
        }
        
        return Market.shared.seed(at: index)
    }
}

