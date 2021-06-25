//
//  UPennButtonStyles.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit

public struct UPennButtonStyles : UPennControlStyle {
    
    public var title: String
    public var selectedImage: UIImage?
    public var deselectedImage: UIImage?
    public var isSelected: Bool
    public var titleColor: UIColor
    public var width: CGFloat
    public var height: CGFloat
    public var backgroundColor: UIColor
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var contentPadding: UIEdgeInsets
    public var imageTitlePadding: CGFloat
    
    public init(
        title: String,
        selectedImage: UIImage? = nil,
        deselectedImage: UIImage? = nil,
        isSelected: Bool=false,
        titleColor: UIColor = .white,
        width: CGFloat,
        height: CGFloat,
        backgroundColor: UIColor = .upennMediumBlue,
        cornerRadius: CGFloat = 0.0,
        borderWidth: CGFloat = 0.0,
        contentPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        imageTitlePadding: CGFloat = 0.0
    ) {
        self.title = title
        self.selectedImage = selectedImage
        self.deselectedImage = deselectedImage
        self.isSelected = isSelected
        self.titleColor = titleColor
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.contentPadding = contentPadding
        self.imageTitlePadding = imageTitlePadding
    }
}
