//
//  UPennKeyboardToolBarAccessoried.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 1/15/22.
//

import Foundation
import UIKit

public protocol UPennKeyboardToolBarAccessoried where Self: UIResponder {
    var toolBarAccessoryView: UIView? { get set }
}

public extension UPennKeyboardToolBarAccessoried {
    
    func addCancelButton(
            title: String?=nil,
            titleSize: CGFloat?=nil,
            titleColor: UIColor?=nil,
            backgroundColor: UIColor?=nil,
            cancelSelectorMethod: Selector?=nil)
    {
        let keyBoardToolbar = UIToolbar()
        keyBoardToolbar.sizeToFit()
        keyBoardToolbar.backgroundColor = backgroundColor ?? .upennRlyLightGray
        
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: title ?? "X", style: .plain, target: self, action: cancelSelectorMethod ?? #selector(self.cancel))
        let cancelButtonAttrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.helvetica(size: titleSize ?? 18),
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): titleColor ?? UIColor.upennWarningRed
        ]
        cancelBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.normal)
        cancelBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.highlighted)
        keyBoardToolbar.items = [flexibleSpaceBarButton, cancelBarButton]
        toolBarAccessoryView = keyBoardToolbar
    }
    
    func removeDoneButton() {
        toolBarAccessoryView = nil
    }
}



