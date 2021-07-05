//
//  UPennButtonsModule.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit

open class PrimaryCTAButton : UIButton, UPennControlStylable {
    
    public static var GetStyle: UPennControlStyle {
        return Self().getStyle as! UPennButtonStyler
    }
    
    open var getStyle: UPennControlStyle {
        return UPennBasicButtonStyle()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.setBaseStyles()
        imageView?.contentMode = .scaleAspectFit
        
        self.setStyles(UPennBasicButtonStyle())
    }
    
    open override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    open func setBaseStyles() {
//        setEnabledStyle()
//        titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        titleLabel?.font = UIFont.helveticaBold(size: 15.0)
        imageView?.contentMode = .scaleAspectFit
        
        self.setStyles(UPennBasicButtonStyle())
    }
    
    open func setEnabledStyle() {
//        setTitleColor(UIColor.white, for: .normal)
//        backgroundColor = UIColor.upennMediumBlue
        backgroundColor = (self.getStyle as! UPennButtonStyler).backgroundColor
    }
    
    open func setDisabledStyle() {
//        setTitleColor(UIColor.darkGray, for: .disabled)
        backgroundColor = (self.getStyle as! UPennButtonStyler).disabledBackgroundColor
    }
    
    open func setStyles(_ styles: UPennControlStyle) {
        let styles = styles as! UPennButtonStyler
        if let titleFont = styles.titleFont {
            self.titleLabel?.font = titleFont
        }
        self.setImage(styles.deselectedImage, for: .normal)
        self.setImage(styles.selectedImage, for: .selected)
        self.isSelected = styles.isSelected ?? false
        self.isHidden = styles.isHidden ?? false
        if let width = styles.width {
            self.frame.size.width = width
        }
        if let height = styles.height {
            self.frame.size.height = height
        }
        if let backgroundColor = styles.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let titleColor = styles.titleColor {
            self.setTitleColor(titleColor, for: .normal)
        }
        if let disabledTitleColor = styles.disabledTitleColor {
            self.setTitleColor(disabledTitleColor, for: .disabled)
        }
        if let disabledBackgroundColor = styles.disabledBackgroundColor {
            
        }
        if let contentPadding = styles.contentPadding {
            self.setInsets(forContentPadding: contentPadding, imageTitlePadding: styles.imageTitlePadding ?? 0)
        }
    }
}

open class PrimaryCTAButtonText : PrimaryCTAButton {
    
    public override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(
            titleColor: .upennMediumBlue,
            backgroundColor: .clear,
            contentPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        )
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        setBaseStyles()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonTextDarkBlue : PrimaryCTAButtonText {
    
    public override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButtonText.self, styles: UPennButtonStyler(
            titleFont: UIFont.helvetica(size: 17.0),
            titleColor: .upennDarkBlue)
        )
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        setBaseStyles()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonTextWhite : PrimaryCTAButtonText {
    
    public override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButtonText.self, styles: UPennButtonStyler(titleColor: .white))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonTextRed : PrimaryCTAButtonText {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButtonText.self, styles: UPennButtonStyler(titleColor: .upennWarningRed))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.setBaseStyles()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonGreen : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(backgroundColor: .upennCTAGreen))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.setBaseStyles()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonRed : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return UPennButtonStyler(backgroundColor: .upennWarningRed)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        isRounded()
        self.setStyles(Self.GetStyle)
    }
}

open class RoundedPrimaryCTAButtonRed : PrimaryCTAButtonRed {
    open override func awakeFromNib() {
        super.awakeFromNib()
        isRounded()
    }
}

open class UPennIconButton : PrimaryCTAButton {
    
    public override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(
            backgroundColor: .clear,
            contentPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                imageTitlePadding: 0.0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        setBaseStyles()
        self.setStyles(Self.GetStyle)
    }
}

open class OutlineCTAButton : PrimaryCTAButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    open override func setBaseStyles() {
        super.setBaseStyles()
        layer.regularBorder()
        layer.blueBorder()
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.upennMediumBlue, for: .normal)
        backgroundColor = UIColor.white
        layer.blueBorder()
    }
    
    open override func setDisabledStyle() {
        super.setDisabledStyle()
        layer.greyBorder()
    }
}

open class RoundedOutlineCTAButton : OutlineCTAButton {
    open override func setBaseStyles() {
        super.setBaseStyles()
        isRounded()
    }
}

open class RedOutlineCTAButton : OutlineCTAButton {
    open override func setBaseStyles() {
        super.setBaseStyles()
        setTitleColor(UIColor.upennWarningRed, for: .normal)
        layer.redBorder()
    }
}

open class RedRoundedOutlineCTAButton : RedOutlineCTAButton {
    open override func setBaseStyles() {
        super.setBaseStyles()
        layer.isRounded()
    }
}

open class DarkRoundedOutlineCTAButton : RoundedOutlineCTAButton {
    open override func setBaseStyles() {
        super.setBaseStyles()
        setTitleColor(UIColor.upennDarkBlue, for: .normal)
        layer.darkBlueBorder()
    }
}

open class CircleOutlineCTAButton : OutlineCTAButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    open override func setBaseStyles() {
        super.setBaseStyles()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setTitleColor(UIColor.upennMediumBlue, for: .normal)
        isCircular()
    }
}

open class GreyCircleOutlineCTAButton : CircleOutlineCTAButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    open override func setBaseStyles() {
        super.setBaseStyles()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.greyBorder()
    }
}
