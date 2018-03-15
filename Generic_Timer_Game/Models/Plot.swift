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
        
        case unactionableState(for: PlotState, action: String)
        
        var description: String {
            switch self {
            case .unactionableState(let state, let action): return "Unable to perform action \(action) in state \(state)"
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
    
    func plant(seed: Seed) throws {
        guard self.state == .tilled else {
            throw PlotState.Error.unactionableState(for: self.state, action: #function)
        }
        self.state = state.advance()
    }
    
    func water(seed: Seed, growingCompleted: @escaping (Bool) -> Void) throws {
        guard self.state == .planted else {
            throw PlotState.Error.unactionableState(for: self.state, action: #function)
        }
        
        InventoryTimerManager.shared.grow(seed: seed) { success in
            guard success == true else {
                return
            }
            self.state = self.state.advance()
            growingCompleted(true)
        }
        self.state = self.state.advance()
        growingCompleted(false)

    }
    
    func harvest(seed: Seed, harvested: @escaping (Bool) -> Void) throws {
        guard self.state == .grown else {
            throw PlotState.Error.unactionableState(for: self.state, action: #function)
        }
        
        self.state = self.state.advance()
        Inventory.shared.add(item: seed.associatedFood, count: 1)
        harvested(true)

    }
    
   
}
