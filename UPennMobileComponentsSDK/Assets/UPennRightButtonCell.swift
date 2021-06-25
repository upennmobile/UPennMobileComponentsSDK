//
//  UPennRightButtonCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/25/21.
//

import Foundation
import UIKit

public protocol UPennRightButtonDelegate : AnyObject {
    func pressedRightButton(_ button: UIButton)
}

open class UPennRightButtonCell : UPennBasicCell, UPennRightButtonViewConfigureInterface {
    
    @IBOutlet weak var buttonView: UPennRightButtonView!
    
    
    open func configure(title: String, styles: UPennButtonStyles?=nil, delegate: UPennRightButtonDelegate) {
        self.buttonView.configure(title: title, styles: styles, delegate: delegate)
    }
}

