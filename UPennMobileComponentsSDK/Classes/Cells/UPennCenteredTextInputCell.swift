//
//  UPennTextInputCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

/// TableView cell for displaying a center-justified UITextField
open class UPennCenteredTextInputCell : UPennBasicCell {
    
    @IBOutlet weak var textInputView: UPennCenteredTextInputView!
    
    
    open func configure(delegate: UITextFieldDelegate) {
        self.textInputView.configure(delegate: delegate)
    }
}

/// TableView cell for displaying a center-justified UITextField with configurations set for a 'username' textfield
open class UPennCenteredUsernameTextFieldCell : UPennCenteredTextInputCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.textInputView.textInput.placeholder = "email"
    }
}

/// TableView cell for displaying a center-justified UITextField with configurations set for a 'password' textfield
open class UPennCenteredPasswordTextFieldCell : UPennCenteredTextInputCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.textInputView.textInput.placeholder = "password"
        self.textInputView.textInput.returnKeyType = .done
        self.textInputView.textInput.isSecureTextEntry = true
    }
}
