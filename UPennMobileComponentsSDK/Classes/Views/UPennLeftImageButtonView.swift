//
//  UPennLeftImageButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit


public protocol UPennLeftImageButtonConfigureInterface {
    
    func configure(title: String, styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate)
    
}

public protocol UPennLeftImageButtonDelegate : AnyObject {
    func pressedLeftImageButton(_ button: UIButton)
}


open class UPennLeftImageButtonView : UPennNibView, UPennLeftImageButtonConfigureInterface {
    
    
    @IBOutlet open weak var button: PrimaryCTAButtonTextDarkBlue!
    
    open weak var delegate: UPennLeftImageButtonDelegate?
    
    public func configure(title: String, styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate) {
        self.delegate = delegate
        button.imageView?.contentMode = .scaleAspectFit
        self.button.setTitle(title, for: .normal)
        self.button.setStyles(styles)
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        self.button.isSelected = !self.button.isSelected
        self.delegate?.pressedLeftImageButton(sender)
    }
    
    
    
}

