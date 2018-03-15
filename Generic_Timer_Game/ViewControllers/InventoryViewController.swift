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
    
    var viewModel: InventoryViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        setupTableView()
        setDelegates()
        viewModel = InventoryViewModel()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        viewModel = InventoryViewModel()
        
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
        viewModel = InventoryViewModel()
        tableView.reloadData()
    }
    
    @IBAction func change(_ sender: Any) {
        
    }
}

extension InventoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KeyValueDetailsTableViewCell.identifier) as? KeyValueDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        let tuple = viewModel?.details(at: indexPath.row)
        
        guard let name = tuple?.item.name,
            let count = tuple?.count else {
                return UITableViewCell()
        }
        
        cell.set(tableView: name, and: count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    
        // cheap error handling
        guard let item = viewModel?.details(at: indexPath.row)?.item else {
            return
        }
        
        let detailsVC = ItemDetailsViewController.create()
        
        detailsVC.item = item
        let vc = tabBarController?.viewControllers?.first as? PlotsViewController

        detailsVC.delegate = vc?.delegate
        present(detailsVC, animated: true)
        
    }
    
}