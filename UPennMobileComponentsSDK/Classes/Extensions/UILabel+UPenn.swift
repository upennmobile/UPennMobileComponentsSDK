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


open class UPennLabel : UILabel, UPennControlStylable {
    
    public static var LabelInstance: UILabel = UILabel()
    
    public static var GetStyle : UPennControlStyle {
        return Self().getStyle as! UPennLabelStyler
    }
    
    open var getStyle: UPennControlStyle {
        return UPennLabelStyler(
            height: 17.0,
            color: .upennBlack)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
    
    open func setStyles(_ styles: UPennControlStyle) {
        let styles = styles as! UPennLabelStyler
        if let font = styles.font {
            self.font = font
        }
        if let height = styles.height {
            self.setFontHeight(size: height)
        }
        if let color = styles.color {
            self.textColor = color
        }
        if let alignment = styles.alignment {
            self.textAlignment = alignment
        }
        if let lineBreakMode = styles.lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        if let numberOfLines = styles.numberOfLines {
            self.numberOfLines = numberOfLines
        }
        if let backgroundColor = styles.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let borderColor = styles.borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        if let borderWidth = styles.borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let cornerRadius = styles.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

open class MultilineLabel : UPennLabel {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(lineBreakMode: .byWordWrapping, numberOfLines: 0)
        )
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class ContactNameLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 20.0, color: .upennDeepBlue))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class ContactDepartmentLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 18.0, color: .upennDarkBlue))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class CameraInstructionLabel : ContactNameLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: ContactNameLabel.self, styles: UPennLabelStyler(color: .white))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class ActionLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(color: .upennMediumBlue))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class ActionSubContentLabel : ActionLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: ActionLabel.self, styles: UPennLabelStyler(height: 15.0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class NoDataInstructionsLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 20.0, color: .upennDarkBlue))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class BannerLabel : UPennLabel {
    
    open override var getStyle: UPennControlStyle {
        
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 25.0, color: .upennDarkBlue, alignment: .center))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class RedBannerLabel : BannerLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: BannerLabel.self, styles: UPennLabelStyler(color: .upennWarningRed))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class BannerLabelWhite : BannerLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: BannerLabel.self, styles: UPennLabelStyler(color: .white))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class TitleLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(font: UIFont.helveticaBold(size: 15.0)).color(.gray))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class ContentLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 16.0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class SubContentLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(height: 13.0).color(.darkGray))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class MultilineContentLabel : MultilineLabel {
   
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: MultilineLabel.self, styles: UPennLabelStyler(height: 16.0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class SectionHeaderTitleLabel : UPennLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: UPennLabel.self, styles: UPennLabelStyler(font: UIFont.helveticaBold(size: 13.0)).color(.white))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class CircularLabel : ContentLabel {
    
    open override var getStyle : UPennControlStyle {
        return self.getStyles(type: ContentLabel.self, styles: UPennLabelStyler().isCircular(Self.LabelInstance))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        Self.LabelInstance = self
        self.setStyles(Self.GetStyle)
    }
}
