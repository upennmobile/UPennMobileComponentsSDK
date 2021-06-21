//
//  UPennCenteredButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

public protocol UPennCenteredButtonDelegate {
    func pressedButton(_ button: UIButton)
}

open class UPennCenteredButtonView : UPennNibView {
    
    @IBOutlet public weak var button: PrimaryCTAButton!
    
    public var delegate: UPennCenteredButtonDelegate?
    
    @IBAction func pressedButton(_ sender: UIButton) {
        
        self.delegate?.pressedButton(sender)
    }
    
    public func configure(title: String, delegate: UPennCenteredButtonDelegate) {
        self.delegate = delegate
        self.button.setTitle(title, for: .normal)
    }
    
}
