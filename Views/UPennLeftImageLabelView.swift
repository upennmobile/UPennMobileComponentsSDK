//
//  UPennLeftImageLabelView.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/8/21.
//

import Foundation
import UIKit


public protocol UPennLeftImageLabelConfigureInterface {
    func configure(image: UIImage, title: String, styles: UPennControlStyle?)
}

public protocol UPennLeftImageLabelDelegate : AnyObject {
    
}

open class UPennLeftImageLabelView : UPennNibView, UPennLeftImageLabelConfigureInterface {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UPennLabel!
    
    
    
    public func configure(image: UIImage, title: String, styles: UPennControlStyle?=nil) {
        self.imageView.image = image
        self.titleLabel.text = title
        if let styles = styles {
            self.titleLabel.setStyles(styles)
        }
    }
    
    
}
