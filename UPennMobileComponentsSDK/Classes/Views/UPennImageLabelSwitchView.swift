//
//  UPennImageLabelSwitchView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/8/21.
//

import Foundation
import UIKit

public protocol UPennControlTaggable {
    var tag: Int { get set }
}

public protocol UPennImageLabelSwitchConfigureInterface {
    
    func configure(_ decorator: UPennImageLabelSwitchControlDecorated)
}

public protocol UPennSwitchControlDelegate : AnyObject {
    func toggledSwitch(_ switchControl: UISwitch)
}

open class UPennImageLabelSwitchView : UPennNibView, UPennImageLabelSwitchConfigureInterface {
    
    
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var imageLabelView: UPennLeftImageLabelView!
    
    
    open weak var delegate: UPennSwitchControlDelegate?
    
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.switchControl.onTintColor = UIColor.upennMediumBlue
    }
    
    @IBAction func toggleSwitchControl(_ sender: UISwitch) {
        self.delegate?.toggledSwitch(sender)
    }
    
    
    open func configure(_ decorator: UPennImageLabelSwitchControlDecorated) {
        self.switchControl.isOn = decorator.isSelected
        self.delegate = decorator.delegate
        self.imageLabelView.configure(image: decorator.image, title: decorator.title, styles: decorator.styles)
    }
    
}
