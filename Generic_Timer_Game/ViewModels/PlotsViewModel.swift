
//
//  PlotsViewModel.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/13/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

class PlotsViewModel {
    
    public func numberOfCells() -> Int {
        return Inventory.shared.totalPlots
    }
    
    public func plot(at index: Int) -> Plot? {
        guard index <= Inventory.shared.totalPlots else {
            print("Index out of bounds")
            return nil
        }
        var plot: Plot?
        do {
            plot = try Inventory.shared.plot(at: index)
        } catch let(error) as GenericError {
            print(error.description)
        } catch {}
        
        return plot
    }
    
    public func cellTapped(at index: Int, updateUI: @escaping ((_ needsUpdate: Bool)-> Void)) {
      
        // TODO: - Need to create selectable seed in UI and handle here
        let food = Food(time: 3, name: "Turnip", minPrice: 10, maxPrice: 15)
        let seed = Seed(food: food, price: 5)
        
        if let plot = plot(at: index) {
            switch plot.state {
            case .empty:
                // till it
                plot.state = plot.state.advance()
            case .tilled:
                // plant it
                do {
                    try plot.plant(seed: seed) 
                } catch let error as PlotState.Error {
                    print(error.description)
                } catch {}
                
            case .planted:
                do {
                    try plot.water(seed: seed) { doneGrowing in
                        if doneGrowing {
                            updateUI(true)
                        }
                    }
                } catch let error as PlotState.Error {
                        print(error.description)
                } catch {}
            case .growing:
                break
            case .grown:
                do {
                    try plot.harvest(seed: seed) { harvested in
                        if harvested {
                            updateUI(true)
                        }
                    }
                } catch let error as PlotState.Error {
                    print(error.description)
                } catch {}
            }
        }
        
    }
}
