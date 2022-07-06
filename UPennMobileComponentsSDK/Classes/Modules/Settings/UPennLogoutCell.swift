//
//  UPennLogoutCell.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/18/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

open class UPennLogoutCell : UPennBasicCell, UPennLeftImageLabelConfigureInterface {
    
    @IBOutlet weak var imageLabelView: UPennLeftImageLabelView!
    
    open func configure(image: UIImage, title: String, styles: UPennControlStyle?=nil) {
        self.imageLabelView.configure(image: image, title: title, styles: styles)
    }
    
}
