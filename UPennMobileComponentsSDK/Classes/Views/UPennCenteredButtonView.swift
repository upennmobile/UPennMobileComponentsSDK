//
//  UPennCenteredButtonView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

public protocol UPennCenteredButtonDelegate : AnyObject {
    func pressedCenterButton(_ button: UIButton)
}

open class UPennCenteredButtonView : UPennNibView, UPennCenteredButtonConfigureInterface {
    
    @IBOutlet public weak var button: PrimaryCTAButton!
    
    public var delegate: UPennCenteredButtonDelegate?
    
    @IBAction func pressedButton(_ sender: UIButton) {
        
        self.delegate?.pressedCenterButton(sender)
    }
    
    public func configure(title: String, delegate: UPennCenteredButtonDelegate, enabled: Bool) {
        self.delegate = delegate
        self.button.setTitle(title, for: .normal)
        self.button.isEnabled = enabled
    }
    
}
