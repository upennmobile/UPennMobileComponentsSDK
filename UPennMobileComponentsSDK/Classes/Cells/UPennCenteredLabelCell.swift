//
//  UPennCenteredLabelCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

open class UPennCenteredLabelCell : UPennBasicCell, UPennLabelViewConfigureInterface {
    
    
    @IBOutlet open weak var labelView: UPennCenteredLabelView!
    
    public func configure(text: String, styles: UPennLabelStyler?=nil) {
        self.labelView.configure(text: text, styles: styles)
    }
}
