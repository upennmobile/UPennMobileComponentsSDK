//
//  UPennLabelStyles.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

public class UPennLabelStyler : UPennControlStyle {
    
    public var height: CGFloat?
    public var color: UIColor?
    public var alignment: NSTextAlignment?
    public var lineBreakMode: NSLineBreakMode?
    public var numberOfLines: Int?
    
    public init(
        height: CGFloat? = nil,
        color: UIColor? = nil,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode?=nil,
        numberOfLines: Int?=nil) {
        self.height = height
        self.color = color
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
    }
    
    public func modify(with styles: UPennControlStyle) -> UPennControlStyle {
        let styles = styles as! UPennLabelStyler
        if let height = styles.height {
            self.height = height
        }
        if let color = styles.color {
            self.color = color
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
        return UPennLabelStyler(height: 25.0, color: .upennDarkBlue, alignment: .center)
    }
}
