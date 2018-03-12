//
//  ItemDetailsViewController.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/11/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailsViewController: UIViewController {
    
    public static let nibName = "ItemDetailsViewController"
    
    var item: Item?

    override func viewDidLoad() {
        
    }
    
    public static func create() -> ItemDetailsViewController {
        return ItemDetailsViewController(nibName: nibName, bundle: Bundle.main)
    }
    
    
}
