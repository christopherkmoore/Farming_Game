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
    var delegate: InventoryChange?
    var amountToSell: Int?

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
        
        guard let amountToSell = amountToSell else { return }
        
        guard let item = item else { return }
        
        let vc = tabBarController?.viewControllers?.first as? PlotsViewController
        
        Inventory.shared.add(gold: price * amountToSell, removing: item, count: amountToSell, with: delegate, updating: vc)
        
        NotificationCenter.default.post(name: Notification.Name.goldChanged, object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sellAll(_ sender: Any) {
        
        guard let text = itemCount.text,
            let count = Int(text),
            validate(inventoryCount: count) else { return }
        
        sellTextField.becomeFirstResponder()
        sellTextField.text = itemCount.text
        sellTextField.endEditing(true)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sellTextField.endEditing(true)
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
    
    // This could be abstracted away entirely to just a return back from a function.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" { return true }
        
        guard let number = Int(string) else { return false }
        
        if textField.text?.isEmpty ?? false {
        
            return validate(inventoryCount: number)
        } else {
            let concatenated = (textField.text ?? "") + string
            guard let total = Int(concatenated) else { return false }
            
            return validate(inventoryCount: total)
        }
        
        return true
    }

    // makes sure that a sell amount is <= the amount contained
    private func validate(inventoryCount: Int) -> Bool {
        
        guard let text = itemCount.text,
            let count = Int(text),
            count >= inventoryCount else {
                return false
        }
        amountToSell = inventoryCount
        
        return true
    }
}
