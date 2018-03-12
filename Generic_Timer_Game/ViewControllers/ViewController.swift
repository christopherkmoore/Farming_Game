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
        
        InventoryTimerManager.shared.increment(item: Turnip(), after: Turnip.time) { success in
            
            guard success == true else {
                return
            }
            
            self.delegate?.inventoryDidChange(sender: self)
            self.updateCount()
        }
    }
    
    func updateCount() {

        buttonCount.text = "Turnips: \(Inventory.shared.item(for: Turnip.accessibilityName)!.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

