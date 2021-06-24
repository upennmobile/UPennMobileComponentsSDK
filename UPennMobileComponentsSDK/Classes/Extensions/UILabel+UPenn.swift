//
//  UILabel+UPenn.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/13/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    func setFontHeight(size: CGFloat) {
        self.font = UIFont.helvetica(size: size)
    }
    
    func setBoldFont(size: CGFloat) {
        self.font = UIFont.helveticaBold(size: size)
    }
    
    // Gesture Recognizer
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "GestureRecognizerAssociatedObjectKey_gestureRecognizer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    /*
     * Create the tap gesture recognizer and
     * store the closure the user passed into the associated object
    */
    func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
        self.textColor = UIColor.upennMediumBlue
    }
    
    /* Every time the user taps on the UILable, this function gets called,
     which triggers the closure we stored */
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}

public protocol UPennStylesCallable { }

extension UPennStylesCallable where Self : UILabel {
    
    var styles: UPennLabelStyles {
        return UPennLabelStyles(height: self.frame.size.height, color: self.textColor, alignment: self.textAlignment)
    }
    
    func setStyles(_ styles: UPennLabelStyles) {
        self.setFontHeight(size: styles.height)
        self.textColor = styles.color
        self.textAlignment = styles.alignment
    }
}

open class UPennLabel : UILabel, UPennStylesCallable {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    open func setBaseStyles() {
        self.setStyles(BaseLabelStyles.Style)
    }
}

open class MultilineLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
}

open class ContactNameLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.upennDeepBlue
        self.setFontHeight(size: 20.0)
    }
}

open class ContactDepartmentLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.upennDarkBlue
        self.setFontHeight(size: 18.0)
    }
}

open class CameraInstructionLabel : ContactNameLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.white
    }
}

open class ActionLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.upennMediumBlue
    }
}

open class ActionSubContentLabel : ActionLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.setFontHeight(size: 15.0)
    }
}

open class NoDataInstructionsLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.upennDarkBlue
        self.setFontHeight(size: 20.0)
    }
}

open class BannerLabel : UPennLabel {
    
    open override func setBaseStyles() {
        self.setStyles(UPennLabelStyles(height: 25.0, color: .upennDarkBlue, alignment: .center))
    }
}

open class RedBannerLabel : BannerLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.upennWarningRed
    }
}

open class BannerLabelWhite : BannerLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.textColor = UIColor.white
    }
}

open class TitleLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.setBoldFont(size: 15.0)
    }
}

open class ContentLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.setFontHeight(size: 16.0)
    }
}

open class SubContentLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.setFontHeight(size: 13.0)
        self.textColor = UIColor.darkGray
    }
}

open class MultilineContentLabel : MultilineLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        self.setFontHeight(size: 16.0)
    }
}

open class SectionHeaderTitleLabel : UPennLabel {
    open override func setBaseStyles() {
        super.setBaseStyles()
        textColor = UIColor.white
        setBoldFont(size: 13)
    }
}
