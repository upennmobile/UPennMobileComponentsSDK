//
//  UPennLabelStyles.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/23/21.
//

import Foundation
import UIKit

public struct UPennLabelStyles : UPennControlStyle {
    
    public var height: CGFloat; var color: UIColor; var alignment: NSTextAlignment
    
    public init(height: CGFloat = 17, color: UIColor = .upennBlack, alignment: NSTextAlignment = .left) {
        self.height = height
        self.color = color
        self.alignment = alignment
    }
    
}

public protocol UPennStylable {
    static var Style : UPennControlStyle { get }
}

public enum BaseLabelStyles : UPennStylable {
    public static var Style : UPennControlStyle {
        return UPennLabelStyles()
    }
}

public enum BannerLabelStyles : UPennStylable {
    
    public static var Style : UPennControlStyle {
        return UPennLabelStyles(height: 25.0, color: .upennDarkBlue, alignment: .center)
    }
}
