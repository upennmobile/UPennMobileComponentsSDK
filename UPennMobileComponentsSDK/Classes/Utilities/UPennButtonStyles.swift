//
//  UPennButtonStyles.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit


open class UPennButtonStyler : UPennControlStyle {
    public func modify(with styles: UPennControlStyle) -> UPennControlStyle {
        let styles = styles as! UPennButtonStyler
        if let titleFont = styles.titleFont {
            self.titleFont = titleFont
        }
        if let deselectedImage = styles.deselectedImage {
            self.deselectedImage = deselectedImage
        }
        if let selectedImage = styles.selectedImage {
            self.selectedImage = selectedImage
        }
        self.isSelected = styles.isSelected ?? false
        self.isHidden = styles.isHidden ?? false
        if let width = styles.width {
            self.width = width
        }
        if let height = styles.height {
            self.height = height
        }
        if let backgroundColor = styles.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let disabledBackgroundColor = styles.disabledBackgroundColor {
            self.disabledBackgroundColor = disabledBackgroundColor
        }
        if let titleColor = styles.titleColor {
            self.titleColor = titleColor
        }
        if let disabledTitleColor = styles.disabledTitleColor {
            self.disabledTitleColor = disabledTitleColor
        }
        if let contentPadding = styles.contentPadding {
            self.contentPadding = contentPadding
        }
        if let imageTitlePadding = styles.imageTitlePadding {
            self.imageTitlePadding = imageTitlePadding
        }
        return self
    }
    
    
    public var selectedImage: UIImage?
    public var deselectedImage: UIImage?
    public var isSelected: Bool?
    public var isHidden: Bool?
    public var titleFont: UIFont?
    public var titleColor: UIColor?
    public var disabledTitleColor: UIColor?
    public var width: CGFloat?
    public var height: CGFloat?
    public var backgroundColor: UIColor?
    public var disabledBackgroundColor: UIColor?
    public var cornerRadius: CGFloat?
    public var borderWidth: CGFloat?
    public var contentPadding: UIEdgeInsets?
    public var imageTitlePadding: CGFloat?
    
    public init(
        selectedImage: UIImage? = nil,
        deselectedImage: UIImage? = nil,
        isSelected: Bool?=false,
        isHidden: Bool?=false,
        titleFont: UIFont? = nil,
        titleColor: UIColor? = nil,
        disabledTitleColor: UIColor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        backgroundColor: UIColor? = nil,
        disabledBackgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        contentPadding: UIEdgeInsets? = nil,
        imageTitlePadding: CGFloat? = nil
    ) {
        self.selectedImage = selectedImage
        self.deselectedImage = deselectedImage
        self.isSelected = isSelected
        self.isHidden = isHidden
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.disabledTitleColor = disabledTitleColor
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.disabledBackgroundColor = disabledBackgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.contentPadding = contentPadding
        self.imageTitlePadding = imageTitlePadding
    }
}

public class UPennBasicButtonStyle : UPennButtonStyler {
    
    override public init(
        selectedImage: UIImage? = nil,
        deselectedImage: UIImage? = nil,
        isSelected: Bool?=false,
        isHidden: Bool?=false,
        titleFont: UIFont? = UIFont.helveticaBold(size: 15.0),
        titleColor: UIColor? = .white,
        disabledTitleColor: UIColor? = .darkGray,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        backgroundColor: UIColor? = .upennMediumBlue,
        disabledBackgroundColor: UIColor? = .lightGray,
        cornerRadius: CGFloat? = 0.0,
        borderWidth: CGFloat? = 0.0,
        contentPadding: UIEdgeInsets? = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
        imageTitlePadding: CGFloat? = 10.0)
    {
        super.init(selectedImage: selectedImage, deselectedImage: deselectedImage, isSelected: isSelected, isHidden: isHidden, titleFont: titleFont, titleColor: titleColor, disabledTitleColor: disabledTitleColor, width: width, height: height, backgroundColor: backgroundColor, disabledBackgroundColor: disabledBackgroundColor, cornerRadius: cornerRadius, borderWidth: borderWidth, contentPadding: contentPadding, imageTitlePadding: imageTitlePadding)
    }
    
}
