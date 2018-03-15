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
        
        guard let plot = viewModel.plot(at: indexPath.item),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlotsCollectionViewCell.identifier, for: indexPath) as? PlotsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = plot.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.cellTapped(at: indexPath.item) { needsUpdate in
            if needsUpdate {
                self.delegate?.inventoryDidChange(sender: self)
                DispatchQueue.main.async {
                    self.plotsLabel.text = "Plots: \(Inventory.shared.emptyPlots)"
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
        
        plotsLabel.text = "Plots: \(Inventory.shared.emptyPlots)"
        collectionView.reloadItems(at: [indexPath])
    }
    
    
}
