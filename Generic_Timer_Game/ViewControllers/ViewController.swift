//
//  ViewController.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/8/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate: InventoryChange?

    @IBOutlet weak var buttonCount: UILabel!
        
    @IBAction func increment(_ sender: Any) {
        
        let turnip = Food(time: 0.5, name: "Turnip", minPrice: 10, maxPrice: 15)
        
        InventoryTimerManager.shared.increment(food: turnip) { success in
            
            guard success == true else {
                return
            }
            
            self.delegate?.inventoryDidChange(sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCount.text = "Gold: \(Inventory.shared.totalGold)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

