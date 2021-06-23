//
//  UPennImageView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/21/21.
//

import Foundation

open class UPennImageView : UPennNibView, UPennImageViewInterface {
    
    
    @IBOutlet open weak var imageView: UIImageView!
    
    open func configure(image: UIImage) {
        self.imageView.image = image
    }
    
}
