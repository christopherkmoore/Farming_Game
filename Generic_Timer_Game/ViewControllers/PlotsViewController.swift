//
//  ViewController.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/8/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import UIKit

public protocol PlotStateChange {
    func plotStateWillChange ()
}

class PlotsViewController: UIViewController, PlotStateChange {
    
    var delegate: InventoryChange?
    // TODO: I want to learn about property observers.
    var viewModel = PlotsViewModel()
    @IBOutlet weak var plotsCollectionView: UICollectionView!
    
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var plotsLabel: UILabel!
    
//    @IBAction func increment(_ sender: Any) {
//
//        let turnip = Food(time: 0.5, name: "Turnip", minPrice: 10, maxPrice: 15)
//
//        InventoryTimerManager.shared.increment(food: turnip) { success in
//
//            guard success == true else {
//                return
//            }
//            
//            self.delegate?.inventoryDidChange(sender: self)
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(goldDidChange), name: Notification.Name.goldChanged, object: nil)
        goldLabel.text = "Gold: \(Inventory.shared.totalGold)"
        plotsLabel.text = "Plots \(Inventory.shared.totalPlots)"
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        plotsCollectionView.delegate = self
        plotsCollectionView.dataSource = self
        
        plotsCollectionView.register(PlotsCollectionViewCell.nib, forCellWithReuseIdentifier: PlotsCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        plotsCollectionView.collectionViewLayout = layout
        
        plotsCollectionView.reloadData()
        
    }
    
    func plotStateWillChange() {
        plotsCollectionView.reloadData()
    }

    @objc func goldDidChange() {
        goldLabel.text = "Gold: \(Inventory.shared.totalGold)"
    }
}

extension PlotsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlotsCollectionViewCell.identifier, for: indexPath) as? PlotsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let plot = try? Inventory.shared.plot(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = plot.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var plot: Plot?
        do {
            plot = try Inventory.shared.plot(at: indexPath.item)
        } catch let(error) as GenericError {
            print(error.description)
        } catch {}

        let food = Food(time: 3, name: "Turnip", minPrice: 10, maxPrice: 15)
        let seed = Seed(food: food, price: 5)
        if let plot = plot {
            switch plot.state {
            case .empty:
                // till it
                plot.state = plot.state.advance()
            case .tilled:
                // plant it
                do {
                    try plot.plant(seed: seed) { doneGrowing in
                        if doneGrowing {
                            self.delegate?.inventoryDidChange(sender: self)
                            DispatchQueue.main.async {
                                self.plotsLabel.text = "Plots: \(Inventory.shared.emptyPlots)"
                                collectionView.reloadItems(at: [indexPath])
                            }
                        }
                    }
                } catch let error as PlotState.Error {
                    print(error.description)
                } catch {}
                
            case .planted:
                break
            case .growing:
                break
            case .grown:
                break
            }
            
            
        }
        
        plotsLabel.text = "Plots: \(Inventory.shared.emptyPlots)"
        collectionView.reloadItems(at: [indexPath])
    }
    
    
}
