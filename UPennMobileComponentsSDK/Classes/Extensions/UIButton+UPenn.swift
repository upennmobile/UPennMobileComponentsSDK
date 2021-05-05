//
//  UIButton+UPenn.swift
//  Phone Book
//
//  Created by Rashad Abdul-Salam on 10/19/17.
//  Copyright © 2017 UPenn. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func isRounded() {
        layer.isRounded()
    }
    
    func isCircular() {
        layer.isCircular(self)
    }
}

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
    
    func setBaseStyles() {
        setEnabledStyle()
        titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        titleLabel?.font = UIFont.helveticaBold(size: 15.0)
    }
    
    func setEnabledStyle() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.upennMediumBlue
    }
    
    func setDisabledStyle() {
        setTitleColor(UIColor.darkGray, for: .disabled)
        backgroundColor = UIColor.lightGray
    }
}

open class PrimaryCTAButtonText : PrimaryCTAButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setBaseStyles()
    }
    
    override func setBaseStyles() {
        super.setBaseStyles()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    open override var isSelected: Bool {
        didSet {
            isSelected ? setEnabledStyle() : setDisabledStyle()
        }
    }
    
    override func setEnabledStyle() {
        super.setEnabledStyle()
        backgroundColor = UIColor.clear
        setTitleColor(UIColor.upennMediumBlue, for: .normal)
    }
    
    override func setDisabledStyle() {
        super.setDisabledStyle()
        backgroundColor = UIColor.clear
    }
}

open class PrimaryCTAButtonTextWhite : PrimaryCTAButtonText {
    override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.white, for: .normal)
    }
}

open class PrimaryCTAButtonTextRed : PrimaryCTAButtonText {
    override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.upennWarningRed, for: .normal)
    }
}

open class PrimaryCTAButtonGreen : PrimaryCTAButton {
    override func setEnabledStyle() {
        super.setEnabledStyle()
        backgroundColor = UIColor.upennCTAGreen
    }
}

open class PrimaryCTAButtonRed : PrimaryCTAButton {
    override func setEnabledStyle() {
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
    
    override func setBaseStyles() {
        super.setBaseStyles()
        layer.regularBorder()
        layer.blueBorder()
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func setEnabledStyle() {
        super.setEnabledStyle()
        setTitleColor(UIColor.upennMediumBlue, for: .normal)
        backgroundColor = UIColor.white
        layer.blueBorder()
    }
    
    override func setDisabledStyle() {
        super.setDisabledStyle()
        layer.greyBorder()
    }
}

open class RoundedOutlineCTAButton : OutlineCTAButton {
    override func setBaseStyles() {
        super.setBaseStyles()
        isRounded()
    }
}

open class RedOutlineCTAButton : OutlineCTAButton {
    override func setBaseStyles() {
        super.setBaseStyles()
        setTitleColor(UIColor.upennWarningRed, for: .normal)
        layer.redBorder()
    }
}

open class RedRoundedOutlineCTAButton : RedOutlineCTAButton {
    override func setBaseStyles() {
        super.setBaseStyles()
        layer.isRounded()
    }
}

open class DarkRoundedOutlineCTAButton : RoundedOutlineCTAButton {
    override func setBaseStyles() {
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
    
    override func setBaseStyles() {
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
    
    override func setBaseStyles() {
        super.setBaseStyles()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.greyBorder()
    }
}
