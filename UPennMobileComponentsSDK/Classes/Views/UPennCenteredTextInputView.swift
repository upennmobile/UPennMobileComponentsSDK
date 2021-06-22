//
//  UPennCenteredTextInputView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

/// UIView for displaying a center-justified UITextField
open class UPennCenteredTextInputView : UPennNibView, UPennTextInputConfigureInterface {
    
    @IBOutlet public weak var textInput: UITextField!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.textInput.autocorrectionType = .no
    }
    
    public func configure(delegate: UITextFieldDelegate, textFieldContent: String?, textFieldTag: Int) {
        self.textInput.delegate = delegate
        self.textInput.text = textFieldContent
        self.textInput.tag = textFieldTag
    }
}
