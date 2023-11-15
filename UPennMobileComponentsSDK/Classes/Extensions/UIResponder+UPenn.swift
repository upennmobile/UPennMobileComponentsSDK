//
//  UIResponder+UPenn.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 1/15/22.
//

import Foundation
import UIKit

extension UIResponder {
    
    @objc open func cancel() {
        resignFirstResponder()
    }
}

extension UISearchBar : UPennKeyboardToolBarAccessoried {
    
    public var toolBarAccessoryView: UIView? {
        get {
           return inputAccessoryView
        }
        set {
            inputAccessoryView = newValue
        }
    }
}

extension UITextField : UPennKeyboardToolBarAccessoried {
    
    public var toolBarAccessoryView: UIView? {
        get {
           return inputAccessoryView
        }
        set {
            inputAccessoryView = newValue
        }
    }
    
    public func toggleAlertAction(action: UIAlertAction) {
        if let text = self.text, text.isBlankSpaceTrimmed {
            action.isEnabled = true
        } else {
            action.isEnabled = false
        }
    }
}

extension UITextView : UPennKeyboardToolBarAccessoried {
    
    public var toolBarAccessoryView: UIView? {
        get {
           return inputAccessoryView
        }
        set {
            inputAccessoryView = newValue
        }
    }
}
