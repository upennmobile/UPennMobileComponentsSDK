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
    
    
    open func configure(styles: UPennButtonStyles, delegate: UPennLeftImageButtonDelegate) {
        self.buttonView.configure(styles: styles, delegate: delegate)
    }
    
    
}

