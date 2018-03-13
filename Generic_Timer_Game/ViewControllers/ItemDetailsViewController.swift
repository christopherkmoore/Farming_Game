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
    
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var sellTextField: UITextField!
    
    public static let nibName = "ItemDetailsViewController"
    
    var item: Item?

    override func viewDidLoad() {
        setupLabels()
        
        sellTextField.delegate = self
        sellTextField.keyboardType = .numberPad
    }
    
    func setupLabels() {
        guard let item = item else {
            return
        }
        itemName.text = item.name
        itemCount.text = String(Inventory.shared.count(for: item))
        price.text = String(describing: item.maxPrice)
    }
    
    public static func create() -> ItemDetailsViewController {
        return ItemDetailsViewController(nibName: nibName, bundle: Bundle.main)
    }
    
    @IBAction func sell(_ sender: Any) {
        
        
        guard let priceText = price.text,
            let price = Int(priceText) else { return }
        
        guard let amountText = sellTextField.text,
            let amount = Int(amountText) else { return }
        
        Inventory.shared.add(gold: price * amount)
    }
    
    @IBAction func sellAll(_ sender: Any) {
        sellTextField.text = itemCount.text

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ItemDetailsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let priceText = price.text,
            let price = Int(priceText) else { return }
        
        guard let textFieldText = textField.text,
            let count = Int(textFieldText) else { return }
        
        textField.text = textFieldText + " * \(String(describing: price)) = \(String(describing: price * count ))"
    }

}
