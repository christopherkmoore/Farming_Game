//
//  MarketplaceViewController.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/10/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

protocol InventoryChange {
    func inventoryDidChange (sender: UIViewController)
}

class InventoryViewController: UIViewController, InventoryChange {
    
    var inventoryViewModel: InventoryViewModel?
    var marketViewModel: MarketViewModel?
    var isInventory = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        setupTableView()
        setDelegates()
        
        inventoryViewModel = InventoryViewModel()
        marketViewModel = MarketViewModel()

    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        inventoryViewModel = InventoryViewModel()
        
    }
    
    func setDelegates () {
        let vc = tabBarController?.viewControllers?.first as? PlotsViewController
        vc?.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(KeyValueDetailsTableViewCell.nib, forCellReuseIdentifier: KeyValueDetailsTableViewCell.identifier)
    }
    
    func inventoryDidChange(sender: UIViewController) {
        inventoryViewModel = InventoryViewModel()
        tableView.reloadData()
    }
    
    @IBAction func change(_ sender: UIButton) {
        isInventory = !isInventory
        if sender.titleLabel?.text == "Inventory" {
            sender.setTitle("Market", for: UIControlState.normal)
        } else {
            sender.setTitle("Inventory", for: UIControlState.normal)
        }
        tableView.reloadData()
    }
}

extension InventoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInventory {
            return inventoryViewModel?.numberOfCells() ?? 0
        } else {
            return marketViewModel?.numberOfCells() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeyValueDetailsTableViewCell.identifier) as? KeyValueDetailsTableViewCell else {
            return UITableViewCell()
        }
        if isInventory {
            let tuple = inventoryViewModel?.details(at: indexPath.row)
            
            guard let name = tuple?.item.name,
                let count = tuple?.count else {
                    return UITableViewCell()
            }
            
            cell.set(tableView: name, and: count)
        } else {
            guard let seed = marketViewModel?.details(at: indexPath.row) else {
                return UITableViewCell()
                
            }
            
            cell.set(tableView: "\(seed.associatedFood.name) seed", and: "1")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    
        // cheap error handling
        guard let item = inventoryViewModel?.details(at: indexPath.row)?.item else {
            return
        }
        
        let detailsVC = ItemDetailsViewController.create()
        
        detailsVC.item = item
        let vc = tabBarController?.viewControllers?.first as? PlotsViewController

        detailsVC.delegate = vc?.delegate
        present(detailsVC, animated: true)
        
    }
    
}
