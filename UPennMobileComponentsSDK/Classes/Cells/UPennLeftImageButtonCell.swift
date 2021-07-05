//
//  UPennLeftImageButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

open class UPennLeftImageButtonCell : UPennBasicCell, UPennLeftImageButtonConfigureInterface {
    
    
    @IBOutlet weak var buttonView: UPennLeftImageButtonView!
    
    
    open func configure(title: String, styles: UPennButtonStyler, delegate: UPennLeftImageButtonDelegate) {
        self.buttonView.configure(title: title, styles: styles, delegate: delegate)
    }
    
    
}

