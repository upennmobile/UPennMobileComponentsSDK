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
    
    public static var ButtonInstance: UIButton = UIButton()
    
    open var getStyle: UPennControlStyle {
        return UPennBasicButtonStyle()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.contentMode = .scaleAspectFit
        
        self.setStyles(UPennBasicButtonStyle())
    }
    
    open override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    open func setBaseStyles() {
        imageView?.contentMode = .scaleAspectFit
        
        self.setStyles(UPennBasicButtonStyle())
    }
    
    open func setEnabledStyle() {
        backgroundColor = (self.getStyle as! UPennButtonStyler).backgroundColor
    }
    
    open func setDisabledStyle() {
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
        if let radius = styles.cornerRadius {
            self.layer.cornerRadius = radius
        }
        if let borderWidth = styles.borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = styles.borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        if let contentPadding = styles.contentPadding {
            self.setInsets(forContentPadding: contentPadding, imageTitlePadding: styles.imageTitlePadding ?? 0)
        }
    }
}

open class PrimaryCTAButtonText : PrimaryCTAButton {
    
    public override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles:
            UPennButtonStyler()
            .titleColor(.upennMediumBlue)
            .backgroundColor(.clear)
            .contentPadding(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            .imageTitlePadding(0)
        )
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
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
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonGreen : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(backgroundColor: .upennCTAGreen))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class PrimaryCTAButtonRed : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(backgroundColor: .upennWarningRed))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class RoundedPrimaryCTAButtonRed : PrimaryCTAButtonRed {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButtonRed.self, styles: UPennButtonStyler().rounded())
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class UPennIconButton : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(backgroundColor: .clear)
                                .contentPadding(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                                .imageTitlePadding(0.0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class OutlineCTAButton : PrimaryCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: PrimaryCTAButton.self, styles: UPennButtonStyler(contentPadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
                                .titleColor(.upennMediumBlue)
                                .backgroundColor(.white)
                                .disabledBackgroundColor(.gray)
                                .disabledTitleColor(.darkGray)
                                .regularBorder()
                                .blueBorder())
    }
    
    open override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
    
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        self.setStyles(Self.GetStyle)
    }
    
    open override func setDisabledStyle() {
        self.setStyles((Self.GetStyle as! UPennButtonStyler)
                        .borderColor(.darkGray)
                        .titleColor(.darkGray))
    }
}

open class RoundedOutlineCTAButton : OutlineCTAButton {
    
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: OutlineCTAButton.self, styles: UPennButtonStyler().rounded())
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class RedOutlineCTAButton : OutlineCTAButton {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: OutlineCTAButton.self, styles: UPennButtonStyler(titleColor: .upennWarningRed).redBorder())
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class RedRoundedOutlineCTAButton : RedOutlineCTAButton {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: RedOutlineCTAButton.self, styles: UPennButtonStyler().rounded())
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class DarkRoundedOutlineCTAButton : RoundedOutlineCTAButton {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: RoundedOutlineCTAButton.self, styles: UPennButtonStyler(titleColor:.upennDarkBlue).darkBlueBorder())
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}

open class CircleOutlineCTAButton : OutlineCTAButton {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: OutlineCTAButton.self, styles: UPennButtonStyler()
                                .isCircular(Self.ButtonInstance)
                                .contentPadding(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                                .imageTitlePadding(0))
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Must capture ButtonInstance to set 'isCircular'
        Self.ButtonInstance = self
        self.setStyles(Self.GetStyle)
    }
}

open class GreyCircleOutlineCTAButton : CircleOutlineCTAButton {
    open override var getStyle: UPennControlStyle {
        return self.getStyles(type: CircleOutlineCTAButton.self, styles: UPennButtonStyler(titleColor:.lightGray).greyBorder())
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setStyles(Self.GetStyle)
    }
}
