//
//  UPennButtonStyles.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit

public struct UPennButtonStyles : UPennControlStyle {
    
    public var selectedImage: UIImage?
    public var deselectedImage: UIImage?
    public var isSelected: Bool
    public var isHidden: Bool
    public var titleFont: UIFont
    public var titleColor: UIColor
    public var disabledTitleColor: UIColor
    public var width: CGFloat?
    public var height: CGFloat?
    public var backgroundColor: UIColor
    public var disabledBackgroundColor: UIColor
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var contentPadding: UIEdgeInsets
    public var imageTitlePadding: CGFloat
    
    public init(
        selectedImage: UIImage? = nil,
        deselectedImage: UIImage? = nil,
        isSelected: Bool=false,
        isHidden: Bool=false,
        titleFont: UIFont = UIFont.helveticaBold(size: 15.0),
        titleColor: UIColor = .white,
        disabledTitleColor: UIColor = .darkGray,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        backgroundColor: UIColor = .upennMediumBlue,
        disabledBackgroundColor: UIColor = .lightGray,
        cornerRadius: CGFloat = 0.0,
        borderWidth: CGFloat = 0.0,
        contentPadding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
        imageTitlePadding: CGFloat = 10.0
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
