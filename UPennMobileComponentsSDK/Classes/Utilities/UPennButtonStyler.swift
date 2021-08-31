//
//  UPennButtonStyler.swift
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
        if let selectedImage = styles.selectedImage {
            self.selectedImage = selectedImage
        }
        if let deselectedImage = styles.deselectedImage {
            self.deselectedImage = deselectedImage
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
        if let radius = styles.cornerRadius {
            self.cornerRadius = radius
        }
        if let borderWidth = styles.borderWidth {
            self.borderWidth = borderWidth
        }
        if let borderColor = styles.borderColor {
            self.borderColor = borderColor
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
    public var borderColor: UIColor?
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
        borderColor: UIColor?=nil,
        contentPadding: UIEdgeInsets? = nil,
        imageTitlePadding: CGFloat? = nil
    ) {
        self.selectedImage = selectedImage
        if let deselected = deselectedImage {
            self.deselectedImage = deselected
        } else {
            self.deselectedImage = selectedImage
        }
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
        self.borderColor = borderColor
        self.contentPadding = contentPadding
        self.imageTitlePadding = imageTitlePadding
    }
    
    /**
     Builder method for setting the button image when selected
     - parameter image: UIImage object to set for selected state
     */
    public func selectedImage(_ image: UIImage) -> UPennButtonStyler {
        self.selectedImage = image
        return self
    }
    /**
     Builder method for setting the button image when NOT selected
     - parameter image: UIImage object to set for de-selected state
     */
    public func deselectedImage(_ image: UIImage) -> UPennButtonStyler {
        self.deselectedImage = image
        return self
    }
    /**
     Builder method for toggling button selection-state
     - parameter selected: Bool to set for selection-state
     */
    public func selected(_ selected: Bool) -> UPennButtonStyler {
        self.isSelected = selected
        return self
    }
    /**
     Builder method for toggling button hidden-state
     - parameter hidden: Bool to set for hidden-state
     */
    public func hidden(_ hidden: Bool) -> UPennButtonStyler {
        self.isHidden = hidden
        return self
    }
    /**
     Builder method for setting button's title font
     - parameter font: UIFont to set for button title font
     */
    public func titleFont(_ font: UIFont) -> UPennButtonStyler {
        self.titleFont = font
        return self
    }
    /**
     Builder method for setting button's title font color
     - parameter color: UIColor to set for button title font color
     */
    public func titleColor(_ color: UIColor) -> UPennButtonStyler {
        self.titleColor = color
        return self
    }
    /**
     Builder method for setting button's title font color when in disabled state
     - parameter color: UIColor to set for button title font in disabled state
     */
    public func disabledTitleColor(_ color: UIColor) -> UPennButtonStyler {
        self.disabledTitleColor = color
        return self
    }
    /**
     Builder method for setting button's width
     - parameter width: CGFloat to set for button's width
     */
    public func width(_ width: CGFloat) -> UPennButtonStyler {
        self.width = width
        return self
    }
    /**
     Builder method for setting button's height
     - parameter height: CGFloat to set for button's height
     */
    public func height(_ height: CGFloat) -> UPennButtonStyler {
        self.height = height
        return self
    }
    /**
     Builder method for setting button's background color when in normal state
     - parameter color: UIColor to set for button background color in normal state
     */
    public func backgroundColor(_ color: UIColor) -> UPennButtonStyler {
        self.backgroundColor = color
        return self
    }
    /**
     Builder method for setting button's background color when in disabled state
     - parameter color: UIColor to set for button background color in disabled state
     */
    public func disabledBackgroundColor(_ color: UIColor) -> UPennButtonStyler {
        self.disabledBackgroundColor = color
        return self
    }
    /**
     Builder method for setting button's cornerRadius
     - parameter radius: CGFloat to set for button's cornerRadius
     */
    public func cornerRadius(_ radius: CGFloat) -> UPennButtonStyler {
        self.cornerRadius = radius
        return self
    }
    /**
     Builder method for setting button's borderWidth
     - parameter width: CGFloat to set for button's borderWidth
     */
    public func borderWidth(_ width: CGFloat) -> UPennButtonStyler {
        self.borderWidth = width
        return self
    }
    /**
     Builder method for setting button's borderWidth
     - parameter color: UIColor to set for button border color
     */
    public func borderColor(_ color: UIColor) -> UPennButtonStyler {
        self.borderColor = color
        return self
    }
    /**
     Builder method for setting button's UIEdgeInsets
     - parameter padding: UIEdgeInsets to set button's content padding
     */
    public func contentPadding(_ padding: UIEdgeInsets) -> UPennButtonStyler {
        self.contentPadding = padding
        return self
    }
    /**
     Builder method for setting button's image title padding
     - parameter padding: CGFloat to set button's image title padding
     */
    public func imageTitlePadding(_ padding: CGFloat) -> UPennButtonStyler {
        self.imageTitlePadding = padding
        return self
    }
    
    public func rounded() -> UPennButtonStyler {
        self.cornerRadius = 5
        return self
    }
    
    public func regularBorder() -> UPennButtonStyler {
        self.borderWidth = 2
        return self
    }
    
    public func thickBorder() -> UPennButtonStyler {
        self.borderWidth = 5
        return self
    }
    
    public func isCircular(_ view: UIView) -> UPennButtonStyler {
        cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        return self
    }
    
    public func redBorder() -> UPennButtonStyler {
        borderColor = UIColor.upennWarningRed
        return self
    }
    
    public func blueBorder() -> UPennButtonStyler {
        borderColor = UIColor.upennMediumBlue
        return self
    }
    
    public func darkBlueBorder() -> UPennButtonStyler {
        borderColor = UIColor.upennDarkBlue
        return self
    }
    
    public func lightGreyBorder() -> UPennButtonStyler {
        borderColor = UIColor.upennRlyLightGray
        return self
    }
    
    public func greyBorder() -> UPennButtonStyler {
        borderColor = UIColor.lightGray
        return self
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
        borderColor: UIColor? = .upennMediumBlue,
        contentPadding: UIEdgeInsets? = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
        imageTitlePadding: CGFloat? = 10.0)
    {
        super.init(selectedImage: selectedImage, deselectedImage: deselectedImage, isSelected: isSelected, isHidden: isHidden, titleFont: titleFont, titleColor: titleColor, disabledTitleColor: disabledTitleColor, width: width, height: height, backgroundColor: backgroundColor, disabledBackgroundColor: disabledBackgroundColor, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor, contentPadding: contentPadding, imageTitlePadding: imageTitlePadding)
    }
    
}
