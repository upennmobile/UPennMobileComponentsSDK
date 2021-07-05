//
//  UPennIconButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/27/21.
//

import Foundation
import UIKit

public protocol UPennCenteredIconButonConfigureInterface {
    
    func configure(image: UIImage, delegate: UPennCenteredIconButtonDelegate, styles: UPennButtonStyler)
    
}

open class UPennCenteredIconButtonCell : UPennBasicCell, UPennCenteredIconButonConfigureInterface {
    
    
    @IBOutlet weak var iconButtonView: UPennCenteredIconButtonView!
    
    
    open func configure(image: UIImage, delegate: UPennCenteredIconButtonDelegate, styles: UPennButtonStyler) {
        self.iconButtonView.configure(image: image, delegate: delegate, styles: styles)
    }
    
}
