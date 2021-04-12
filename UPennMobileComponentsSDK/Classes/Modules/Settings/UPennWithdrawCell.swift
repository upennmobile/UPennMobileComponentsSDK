//
//  UPennWithdrawCell.swift
//  PipPenn Patient
//
//  Created by Igor Eydman on 9/9/20.
//  Copyright © 2020 University of Pennsylvania. All rights reserved.
//

import Foundation

import UIKit

class UPennWithdrawCell : UPennBasicCell {
    
    @IBOutlet weak var withdrawLabel: UPennLabel!
    @IBOutlet weak var withdrawImage: UIImageView!
    
    func configure() {
        self.withdrawLabel.textColor = UIColor.upennWarningRed
        self.withdrawImage.tintColor = UIColor.upennWarningRed
    }
}
