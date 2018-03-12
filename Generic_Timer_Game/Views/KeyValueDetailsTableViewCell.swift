//
//  KeyValueDetailsTableViewCell.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/10/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

class KeyValueDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    public static let identifier = "KeyValueDetailsTableViewCell"
    public static let nib = UINib(nibName: "KeyValueDetailsTableViewCell", bundle: nil)
    
    func set(tableView key: String, and value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
}
