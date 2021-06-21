//
//  UPennTextInputCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

/// Interface for an object to properly handle login view-model functionality

public protocol UPennTextInputConfigureInterface {
    func configure(delegate: UITextFieldDelegate, textFieldTag: Int)
}

/// TableView cell for displaying a center-justified UITextField
open class UPennCenteredTextInputCell : UPennBasicCell, UPennTextInputConfigureInterface {
    
    @IBOutlet weak var textInputView: UPennCenteredTextInputView!
    
    
    open func configure(delegate: UITextFieldDelegate, textFieldTag: Int) {
        self.textInputView.configure(delegate: delegate, textFieldTag: textFieldTag)
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
