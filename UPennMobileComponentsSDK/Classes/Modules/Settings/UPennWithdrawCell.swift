//
//  UPennWithdrawCell.swift
//  PipPenn Patient
//
//  Created by Igor Eydman on 9/9/20.
//  Copyright © 2020 University of Pennsylvania. All rights reserved.
//

import Foundation

import UIKit

open class UPennWithdrawCell : UPennBasicCell, UPennLeftImageLabelConfigureInterface {
    
    @IBOutlet weak var withdrawLabel: UPennLabel!
    @IBOutlet weak var withdrawImage: UIImageView!
    
    @IBOutlet weak var imageLabelView: UPennLeftImageLabelView!
    
    
    open func configure() {
        self.withdrawLabel.textColor = UIColor.upennWarningRed
        self.withdrawImage.tintColor = UIColor.upennWarningRed
    }
    
    open func configure(image: UIImage, title: String, styles: UPennControlStyle?=nil) {
        self.imageLabelView.configure(image: image, title: title, styles: styles)
    }
}
