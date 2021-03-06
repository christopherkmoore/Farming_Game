//
//  Extensions.swift
//  Generic_Timer_Game
//
//  Created by Christopher Moore on 3/12/18.
//  Copyright © 2018 Christopher Moore. All rights reserved.
//

import Foundation
import UIKit

enum GenericError: Swift.Error, Description {
    case indexOutOfBounds
    
    var description: String {
        switch self {
        case .indexOutOfBounds: return "Index out of bound for array"
        }
    }
}
protocol Description {
    var description: String { get }
}

extension Notification.Name {
    public static let goldChanged = Notification.Name(rawValue: Inventory.goldNotificationKey)
}

extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
