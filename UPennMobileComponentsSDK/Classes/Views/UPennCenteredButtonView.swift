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
    
    public func configure(with decorator: UPennCenteredButtonDecorator) {
        self.delegate = decorator.delegate
        self.button.setTitle(decorator.title, for: .normal)
        self.button.tag = decorator.tag
        self.button.isEnabled = decorator.enabled
        self.button.isHidden = decorator.hide
        if let styles = decorator.styles {
            self.button.setStyles(styles)
        }
    }
    
}

open class UPennCenteredButtonDecorator {
    var title: String
    var delegate: UPennCenteredButtonDelegate
    var styles: UPennControlStyle?=nil
    var enabled: Bool = true
    var tag: Int = 0
    var hide: Bool = false
    
    public init(
        title: String,
        delegate: UPennCenteredButtonDelegate,
        styles: UPennControlStyle?=nil,
        enabled: Bool = true,
        tag: Int = 0,
        hide: Bool = false
    ) {
        self.title = title
        self.delegate = delegate
        self.styles = styles
        self.enabled = enabled
        self.tag = tag
        self.hide = hide
    }
}
