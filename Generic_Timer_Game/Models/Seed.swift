//
//  Seed.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

class Seed {
    
    var associatedFood: Food
    var price: Int
    var growTime: Double? {
        return associatedFood.time
    }
    
    // TODO: Make failable initializer if not enough $$$
    init(food: Food, price: Int) {
        self.associatedFood = food
        self.price = price
    }
    
}
