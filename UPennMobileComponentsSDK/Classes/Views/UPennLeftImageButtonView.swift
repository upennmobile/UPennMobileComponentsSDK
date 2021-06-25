//
//  UPennLeftImageButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit


public protocol UPennLeftImageButtonConfigureInterface {
    
    func configure(styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate)
    
}

public protocol UPennLeftImageButtonDelegate : AnyObject {
    func pressedLeftImageButton(_ button: UIButton)
}


open class UPennLeftImageButtonView : UPennNibView, UPennLeftImageButtonConfigureInterface {
    
    
    @IBOutlet open weak var button: PrimaryCTAButtonText!
    
    open weak var delegate: UPennLeftImageButtonDelegate?
    
    public func configure(styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate) {
        self.delegate = delegate
        self.button.setStyles(styles)
        button.imageView?.contentMode = .scaleAspectFit
        button.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: -110, bottom: 0, right: -50), imageTitlePadding: -50)
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        self.button.isSelected = !self.button.isSelected
        self.delegate?.pressedLeftImageButton(sender)
    }
    
    
    
}

