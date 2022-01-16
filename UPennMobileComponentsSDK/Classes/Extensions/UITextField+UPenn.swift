//
//  UITextField+UPenn.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/26/21.
//

import Foundation
import UIKit

open class UPennTextField : UITextField {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addCancelButton()
    }
    
    public init(
        frame: CGRect?=nil,
        title: String?=nil,
        titleSize: CGFloat?=nil,
        titleColor: UIColor?=nil,
        backgroundColor: UIColor?=nil,
        cancelSelectorMethod: Selector?=nil)
    {
        super.init(frame: frame ?? .zero)
        self.addCancelButton(
            title: title,
            titleSize: titleSize,
            titleColor: titleColor,
            backgroundColor: backgroundColor,
            cancelSelectorMethod: cancelSelectorMethod)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

open class UPennSearchBar : UISearchBar {
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addCancelButton()
    }
    
    public init(
        frame: CGRect?=nil,
        title: String?=nil,
        titleSize: CGFloat?=nil,
        titleColor: UIColor?=nil,
        backgroundColor: UIColor?=nil,
        cancelSelectorMethod: Selector?=nil)
    {
        super.init(frame: frame ?? .zero)
        self.addCancelButton(
            title: title,
            titleSize: titleSize,
            titleColor: titleColor,
            backgroundColor: backgroundColor,
            cancelSelectorMethod: cancelSelectorMethod)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

open class UPennTextView : UITextView {
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addCancelButton()
    }
    
    public init(
        frame: CGRect?=nil,
        textContainer: NSTextContainer?=nil,
        title: String?=nil,
        titleSize: CGFloat?=nil,
        titleColor: UIColor?=nil,
        backgroundColor: UIColor?=nil,
        cancelSelectorMethod: Selector?=nil)
    {
        super.init(frame: frame ?? .zero, textContainer: textContainer)
        self.addCancelButton(
            title: title,
            titleSize: titleSize,
            titleColor: titleColor,
            backgroundColor: backgroundColor,
            cancelSelectorMethod: cancelSelectorMethod)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

