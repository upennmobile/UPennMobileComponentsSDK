//
//  UPennCenteredLabelView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

public protocol UPennLabelViewConfigureInterface {
    func configure(text: String, styles: UPennLabelStyles)
}

open class UPennCenteredLabelView : UPennNibView, UPennLabelViewConfigureInterface {
    
    
    @IBOutlet open weak var textLabel: UPennLabel!
    
    
    open func configure(text: String, styles: UPennLabelStyles) {
        self.textLabel.text = text
        self.textLabel.setStyles(styles)
    }
    
    
}



