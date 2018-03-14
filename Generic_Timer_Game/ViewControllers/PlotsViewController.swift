//
//  ViewController.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/8/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import UIKit


class PlotsViewController: UIViewController {
    
    var delegate: InventoryChange?
    // TODO: I want to learn about property observers.
    var viewModel: PlotsViewModel?
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
    }
    
    func setupCollectionView() {
        
    }

    @objc func goldDidChange() {
        goldLabel.text = "Gold: \(Inventory.shared.totalGold)"
    }
}

extension PlotsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
