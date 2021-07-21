//
//  UPennRightButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/25/21.
//

import Foundation
import UIKit


public protocol UPennRightButtonViewConfigureInterface {
    
    func configure(title: String, styles: UPennButtonStyler?, delegate: UPennRightButtonDelegate)
}

open class UPennRightButtonView : UPennNibView, UPennRightButtonViewConfigureInterface {
    
    @IBOutlet open weak var button: PrimaryCTAButtonTextDarkBlue!
    
    open weak var delegate: UPennRightButtonDelegate?
    
    open func configure(title: String, styles: UPennButtonStyler?=nil, delegate: UPennRightButtonDelegate) {
        self.delegate = delegate
        self.button.setTitle(title, for: .normal)
        if let styles = styles {
            self.button.setStyles(styles)
        }
    }
    
    
    @IBAction func pressedButton(_ sender: UIButton) {
        self.delegate?.pressedRightButton(sender)
    }
    
    
}
