//
//  UIButton+UPenn.swift
//  Phone Book
//
//  Created by Rashad Abdul-Salam on 10/19/17.
//  Copyright © 2017 UPenn. All rights reserved.
//

import Foundation
import UIKit

extension UIButton : UPennStylesSettable {
    
    public func isRounded() {
        layer.isRounded()
    }
    
    public func isCircular() {
        layer.isCircular(self)
    }
    
    public func setInsets(
            forContentPadding contentPadding: UIEdgeInsets,
            imageTitlePadding: CGFloat) {
            self.contentEdgeInsets = UIEdgeInsets(
                top: contentPadding.top,
                left: contentPadding.left,
                bottom: contentPadding.bottom,
                right: contentPadding.right + imageTitlePadding
            )
            self.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: imageTitlePadding,
                bottom: 0,
                right: -imageTitlePadding
            )
        }
    
    public func setStyles(_ styles: UPennControlStyle) {
        let styles = styles as! UPennButtonStyles
        self.setTitle(styles.title, for: .normal)
        self.setImage(styles.deselectedImage, for: .normal)
        self.setImage(styles.selectedImage, for: .selected)
        self.isSelected = styles.isSelected
        self.frame.size.width = styles.width
        self.frame.size.height = styles.height
        self.backgroundColor = styles.backgroundColor
        self.setTitleColor(styles.titleColor, for: .normal)
        self.setTitleColor(styles.titleColor, for: .selected)
        self.contentEdgeInsets = UIEdgeInsets(
            top: styles.contentPadding.top,
            left: styles.contentPadding.left,
            bottom: styles.contentPadding.bottom,
            right: styles.contentPadding.right + styles.imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: styles.imageTitlePadding,
            bottom: 0,
            right: -styles.imageTitlePadding
        )
    }
}
