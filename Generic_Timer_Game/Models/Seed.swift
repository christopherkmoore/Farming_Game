//
//  Seed.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

public class Seed {
    
    var associatedFood: Food
    var price: Int
    var experience: Int
    var growTime: Double
    
    init(from seed: StaticGrowable.Type) {
        let food = Food(time: seed.growTime, name: seed.name, minPrice: seed.minPrice, maxPrice: seed.maxPrice)
        self.associatedFood = food
        self.price = seed.seedPrice
        self.experience = seed.experience
        self.growTime = seed.growTime
    }
    
}
