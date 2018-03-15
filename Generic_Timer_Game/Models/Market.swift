//
//  Market.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/14/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation


class Market {
    
    public static let shared = Market()

    let inventory: [Item] = []
    private var seed: [Seed] = []
    var possibleSeeds: [StaticGrowable.Type] = [Turnip.self, Tomato.self]
    
    var totalSeeds: Int {
        return seed.count
    }
    
    init() {
        generateSeeds()
        generateInventory()
    }
    
    public func generateInventory() {
        
    }
    
    public func generateSeeds() {
                
        var seeds = possibleSeeds
            .filter { seed in
                return Player.shared.level >= seed.availableAtLevel
            }
            .flatMap {
                return Seed(from: $0)
            }
        
        self.seed = seeds
    }
    
    public func seed(at index: Int) -> Seed {
        return seed[index]
    }
    
}
