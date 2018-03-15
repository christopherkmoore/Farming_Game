//
//  Plot.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation

enum PlotState: Int {
    case empty
    case tilled
    case planted
    case growing
    case grown
    
    enum Error: Swift.Error, EnumDescription  {
        
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
}

class Plot {
    
    var state: PlotState = .empty
    
    func plant(seed: Seed) throws {
        guard self.state == .tilled else {
            throw PlotState.Error.unableToPlant(for: self.state)
        }
        self.state = state.advance()
    }
}
