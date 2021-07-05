//
//  UPennIconButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/29/21.
//

import Foundation
import UIKit

public protocol UPennCenteredIconButtonDelegate {
    func pressedIconButton(_ button: UIButton)
}

open class UPennCenteredIconButtonView : UPennNibView, UIGestureRecognizerDelegate, UPennCenteredIconButonConfigureInterface {
    
    @IBOutlet weak var iconButton: UPennIconButton!
    var identifier: String!
    var delegate: UPennCenteredIconButtonDelegate?
    
    @IBAction func pressedContactButton(_ sender: UIButton) {
        self.delegate?.pressedIconButton(sender)
    }
    
    open func configure(image: UIImage, delegate: UPennCenteredIconButtonDelegate, styles: UPennButtonStyler) {
        
        self.iconButton.setImage(image, for: .normal)
        self.delegate = delegate
        self.iconButton.setStyles(styles)
    }
    
}
