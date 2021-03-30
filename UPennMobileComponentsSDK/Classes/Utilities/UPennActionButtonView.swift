//
//  UPennActionButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/29/21.
//

import Foundation
import UIKit

protocol UPennIconButtonDelegate {
    func pressedIconButton(identifier: String)
}

class UPennIconButtonView : UPennNibView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var iconButton: UPennIconButton!
    var identifier: String!
    var delegate: UPennIconButtonDelegate?
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.setupGestureRecognizer()
//    }
    
    @IBAction func pressedContactButton(_ sender: UIButton) {
        self.delegate?.pressedIconButton(identifier: self.identifier)
    }
    
    func configure(_ id: String, image: UIImage, delegate: UPennIconButtonDelegate, enabled: Bool=true) {
        self.identifier = id
        self.iconButton.setImage(image, for: .normal)
        self.delegate = delegate
        self.enable(isEnabled: enabled)
    }
    
}

private extension UPennIconButtonView {
    
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
