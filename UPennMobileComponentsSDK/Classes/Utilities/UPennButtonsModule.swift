//
//  UPennButtonsModule.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit

open class PrimaryCTAButton : UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setBaseStyles()
    }
    
    open override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    open func setBaseStyles() {
        setEnabledStyle()
        titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        titleLabel?.font = UIFont.helveticaBold(size: 15.0)
//        imageView?.contentMode = .scaleAspectFit
    }
    
    open func setEnabledStyle() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.upennMediumBlue
    }
    
    open func setDisabledStyle() {
        setTitleColor(UIColor.darkGray, for: .disabled)
        backgroundColor = UIColor.lightGray
    }
    
    
}

open class PrimaryCTAButtonText : PrimaryCTAButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setBaseStyles()
    }
    
    open override func setBaseStyles() {
        super.setBaseStyles()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    open override var isSelected: Bool {
        didSet {
            isSelected ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        backgroundColor = UIColor.clear
        setTitleColor(UIColor.upennMediumBlue, for: .normal)
    }
    
    open override func setDisabledStyle() {
        super.setDisabledStyle()
        backgroundColor = UIColor.clear
    }
}

open class PrimaryCTAButtonTextWhite : PrimaryCTAButtonText {
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.white, for: .normal)
    }
}

open class PrimaryCTAButtonTextRed : PrimaryCTAButtonText {
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.upennWarningRed, for: .normal)
    }
}

open class PrimaryCTAButtonGreen : PrimaryCTAButton {
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        backgroundColor = UIColor.upennCTAGreen
    }
}

open class PrimaryCTAButtonRed : PrimaryCTAButton {
    open override func setEnabledStyle() {
        super.setEnabledStyle()
        backgroundColor = UIColor.upennWarningRed
    }
}

open class RoundedPrimaryCTAButtonRed : PrimaryCTAButtonRed {
    open override func awakeFromNib() {
        super.awakeFromNib()
        isRounded()
    }
}

open class UPennIconButton : UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
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
