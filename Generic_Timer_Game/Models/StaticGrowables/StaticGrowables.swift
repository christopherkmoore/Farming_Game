//
//  StaticGrowables.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/14/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

// everything in this folder MUST conform to this protocol.
// it's how seeds and other junk get created without
// creating types

protocol StaticGrowable {
    static var name: String { get }
    static var seedPrice: Int { get }
    static var growTime: Double { get }
    static var experience: Int { get }
    static var availableAtLevel: Int { get }
    static var minPrice: Int { get }
    static var maxPrice: Int { get }
    
}
