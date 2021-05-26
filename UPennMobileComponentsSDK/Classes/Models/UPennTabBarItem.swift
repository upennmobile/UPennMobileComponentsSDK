//
//  UPennTabBarItem.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 5/25/21.
//

import Foundation
import UIKit

public protocol UPennTabBarItemed {
    static var TabBarItem : UPennTabBarItem { get set }
}

open class UPennTabBarItem {
    
    open var title: String
    open var selectedImage, unSelectedImage: UIImage?
    
    public init(
        title: String,
        selectedImage: UIImage?,
        unselectedImage: UIImage?) {
        self.title = title
        self.selectedImage = selectedImage
        self.unSelectedImage = unselectedImage
    }
    
}
