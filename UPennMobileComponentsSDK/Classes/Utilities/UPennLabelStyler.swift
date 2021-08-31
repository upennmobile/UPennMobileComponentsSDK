//
//  UPennLabelStyler.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

public class UPennLabelStyler : UPennControlStyle {
    public var font: UIFont?
    public var height: CGFloat?
    public var color: UIColor?
    public var alignment: NSTextAlignment?
    public var lineBreakMode: NSLineBreakMode?
    public var numberOfLines: Int?
    public var backgroundColor: UIColor?
    public var borderColor: UIColor?
    public var cornerRadius: CGFloat?
    public var borderWidth: CGFloat?
    
    public init(
        font: UIFont? = nil,
        height: CGFloat? = nil,
        color: UIColor? = nil,
        backgroundColor: UIColor? = nil,
        borderColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode?=nil,
        numberOfLines: Int?=nil) {
        self.font = font
        self.height = height
        self.color = color
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
    }
    
    public func modify(with styles: UPennControlStyle) -> UPennControlStyle {
        let styles = styles as! UPennLabelStyler
        if let font = styles.font {
            self.font = font
        }
        if let height = styles.height {
            self.height = height
        }
        if let color = styles.color {
            self.color = color
        }
        if let backgroundColor = styles.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let cornerRadius = styles.cornerRadius {
            self.cornerRadius = cornerRadius
        }
        if let borderColor = styles.borderColor {
            self.borderColor = borderColor
        }
        if let borderWidth = styles.borderWidth {
            self.borderWidth = borderWidth
        }
        if let alignment = styles.alignment {
            self.alignment = alignment
        }
        if let lineBreakMode = styles.lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        
        if let numberOfLines = styles.numberOfLines {
            self.numberOfLines = numberOfLines
        }
        return self
    }
    /**
     Builder method for setting label's font
     - parameter font: UIFont to set for label's font
     */
    public func font(_ font: UIFont) -> UPennLabelStyler {
        self.font = font
        return self
    }
    /**
     Builder method for setting label's height
     - parameter height: CGFloat to set for label's height
     */
    public func height(_ height: CGFloat) -> UPennLabelStyler {
        self.height = height
        return self
    }
    /**
     Builder method for setting label's color
     - parameter color: CGFloat to set for label's color
     */
    public func color(_ color: UIColor) -> UPennLabelStyler {
        self.color = color
        return self
    }
    /**
     Builder method for setting label's alignment
     - parameter alignment: NSTextAligment to set for the label
     */
    public func alignment(_ alignment: NSTextAlignment) -> UPennLabelStyler {
        self.alignment = alignment
        return self
    }
    /**
     Builder method for setting label's lineBreakMode
     - parameter lineBreak: NSLineBreakMode to set for the label
     */
    public func lineBreakMode(_ lineBreak: NSLineBreakMode) -> UPennLabelStyler {
        self.lineBreakMode = lineBreak
        return self
    }
    /**
     Builder method for setting label's line-number
     - parameter numLines: Int to set for label's line number
     */
    public func numberOfLines(_ numLines: Int) -> UPennLabelStyler {
        self.numberOfLines = numLines
        return self
    }
    /**
     Builder method for setting button's background color when in normal state
     - parameter color: UIColor to set for button background color in normal state
     */
    public func backgroundColor(_ color: UIColor) -> UPennLabelStyler {
        self.backgroundColor = color
        return self
    }
    
    public func borderColor(_ color: UIColor) -> UPennLabelStyler {
        self.borderColor = color
        return self
    }
    
    public func borderWidth(_ width: CGFloat) -> UPennLabelStyler {
        self.borderWidth = width
        return self
    }
    
    public func cornerRadius(_ radius: CGFloat) -> UPennLabelStyler {
        self.cornerRadius = radius
        return self
    }
    
    public func regularBorder() -> UPennLabelStyler {
        self.borderWidth = 2
        return self
    }
    
    public func isCircular(_ view: UIView) -> UPennLabelStyler {
        self.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        return self
    }
    
}

public protocol UPennStylable {
    static var Style : UPennControlStyle { get }
}

public enum BaseLabelStyles : UPennStylable {
    public static var Style : UPennControlStyle {
        return UPennLabelStyler()
    }
}

public enum BannerLabelStyles : UPennStylable {
    
    public static var Style : UPennControlStyle {
        return UPennLabelStyler()
            .height(25.0)
            .color(.upennDarkBlue)
            .alignment(.center)
    }
}
