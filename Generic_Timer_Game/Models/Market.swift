//
//  Market.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/14/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation


class Market {
    
    let inventory: [Item] = []
    var seed: [Seed] = []
    var possibleSeeds: [StaticGrowable.Type] = [Turnip.self, Tomato.self]
    
    public static let shared = Market()
    
    init() {
        generateSeeds()
        generateInventory()
    }
    
    public func generateInventory() {
        
    }
    
    public func generateSeeds() {
                
        var seeds = possibleSeeds
            .filter { seed in
                return Player.shared.level < seed.availableAtLevel
            }
            .flatMap {
                return Seed(from: $0)
            }
        
        self.seed = seeds
    }
    
    
}
