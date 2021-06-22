//
//  UPennImageViewCell.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/21/21.
//

import Foundation
import UIKit

public protocol UPennImageViewInterface {
    func configure(image: UIImage)
}

class UPennImageViewCell : UPennBasicCell, UPennImageViewInterface {
    
   
    @IBOutlet weak var imageArea: UPennImageView!
    
    
    func configure(image: UIImage) {
        self.imageArea.configure(image: image)
    }
}
