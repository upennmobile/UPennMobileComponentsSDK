//
//  UPennKeyboardToolbar.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/26/21.
//

import Foundation
import UIKit

open class UPennKeyboardToolbar : UIToolbar {
    
    public enum DismissButtonType {
        case Done, Cancel
    }
    
    private var parentResponder: UIResponder!
    
    open func makeDismissButton(_ type: DismissButtonType, for responder: UIResponder) -> UPennKeyboardToolbar {
        self.parentResponder = responder
        sizeToFit()
        backgroundColor = UIColor.upennRlyLightGray
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var dismissBarButton = UIBarButtonItem()
        var cancelButtonAttrs : [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : UIFont.helvetica(size: 18)]
        switch type {
        case .Done:
            dismissBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(UPennKeyboardToolbar.cancel))
            cancelButtonAttrs[NSAttributedString.Key.foregroundColor] = UIColor.upennMediumBlue
        case .Cancel:
            dismissBarButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(UPennKeyboardToolbar.cancel))
            cancelButtonAttrs[NSAttributedString.Key.foregroundColor] = UIColor.upennWarningRed
        }
        dismissBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.normal)
        dismissBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.highlighted)
        items = [flexibleSpaceBarButton, dismissBarButton]
        return self
    }
    
    @objc open func cancel() {
        self.parentResponder.resignFirstResponder()
    }
}

