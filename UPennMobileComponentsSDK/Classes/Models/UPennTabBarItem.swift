//
//  UPennTabBarItem.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 5/25/21.
//

import Foundation
import UIKit

public protocol UPennTabBarItemed {
    static var TabBarItem : UPennTabBarItem { get }
}

open class UPennTabBarItem : UITabBarItem {
    
    public var unSelectedImage: UIImage?
    
    public init(
        title: String,
        selectedImage: UIImage?,
        unselectedImage: UIImage?) {
            super.init()
        self.title = title
        self.selectedImage = selectedImage
        self.unSelectedImage = unselectedImage
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
