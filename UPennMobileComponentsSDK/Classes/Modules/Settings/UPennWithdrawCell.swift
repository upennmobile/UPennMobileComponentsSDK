//
//  UPennWithdrawCell.swift
//  PipPenn Patient
//
//  Created by Igor Eydman on 9/9/20.
//  Copyright © 2020 University of Pennsylvania. All rights reserved.
//

import Foundation

import UIKit

class UPennWithdrawCell : UPennBasicCell, UPennLeftImageButtonConfigureInterface {
    
    
    
    @IBOutlet weak var withdrawLabel: UPennLabel!
    @IBOutlet weak var withdrawImage: UIImageView!
    
    @IBOutlet weak var buttonView: UPennLeftImageButtonView!
    
    
    func configure() {
        self.withdrawLabel.textColor = UIColor.upennWarningRed
        self.withdrawImage.tintColor = UIColor.upennWarningRed
    }
    
    func configure(title: String, styles: UPennButtonStyler, delegate: UPennLeftImageButtonDelegate) {
        self.buttonView.configure(title: title, styles: styles, delegate: delegate)
    }
}
