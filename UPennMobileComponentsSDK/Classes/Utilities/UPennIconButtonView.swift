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
    
    open func configure(image: UIImage, delegate: UPennCenteredIconButtonDelegate, styles: UPennButtonStyles) {
        
        self.iconButton.setImage(image, for: .normal)
        self.delegate = delegate
        self.iconButton.setStyles(styles)
    }
    
}

private extension UPennCenteredIconButtonView {
    
    func enable(isEnabled: Bool) {
        self.iconButton.isHidden = isEnabled ? false : true
    }
    
//    func setupGestureRecognizer() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.pressedContactButton(_:)))
//        tap.delegate = self
//        tap.numberOfTapsRequired = 1
//        iconLabel.isUserInteractionEnabled = true
//        iconLabel.addGestureRecognizer(tap)
//    }
}
