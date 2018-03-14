//
//  Plot.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

enum PlotState: Int {
    case empty
    case tilled
    case planted
    case growing
    case grown
    
    enum Error: Swift.Error, Description  {
        
        case unableToPlant(for: PlotState)
        
        var description: String {
            switch self {
            case .unableToPlant(let state): return "Unable to plant in state \(state)"
            }
        }
    }
    // goes to the next available state, otherwise goes back to empty
    func advance() -> PlotState {
        guard let newState = PlotState(rawValue: self.rawValue + 1) else {
            return .empty
        }
        return newState
    }
    
    func image() -> UIColor {
        switch self {
        case .empty: return .green
        case .tilled: return .brown
        case .planted: return .blue
        case .growing: return .yellow
        case .grown: return .black
        }
    }
    
}

class Plot {
    
    var state: PlotState = .empty
    var image: UIColor {
        return state.image()
    }
    
    func plant(seed: Seed, growingCompleted: @escaping (Bool) -> Void) throws {
        guard self.state == .tilled else {
            throw PlotState.Error.unableToPlant(for: self.state)
        }
        self.state = state.advance()
        
        InventoryTimerManager.shared.increment(food: seed.associatedFood) { success, sender in
            guard success == true else {
                return
            }
            self.state = self.state.advance()
            Inventory.shared.add(item: seed.associatedFood, count: 1)
            growingCompleted(true)
        }
        growingCompleted(false)
        self.state = state.advance()
        
    }
    
   
}
