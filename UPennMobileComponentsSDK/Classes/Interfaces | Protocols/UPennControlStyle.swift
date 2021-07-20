//
//  UPennControlStyle.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/24/21.
//

import Foundation
import UIKit

/// Interface for Label and Button Stylizers to manage style properties
public protocol UPennControlStyle {
    /**
     Builder method for easy, bulk-modifying/updating UPennControlStyle objects and returning the modified object
     - parameter styles: UPennControlStyle object with all the styles for modification
     */
    func modify(with styles: UPennControlStyle) -> UPennControlStyle
}

/// Protocol to group objects like Labels and Buttons for styling purposes
public protocol UPennControlStylable {
    /// Class-level getter for returning UPennControlStyle
    static var GetStyle : UPennControlStyle { get }
    /// Instance-level getter for returning UPennControlStyle
    var getStyle: UPennControlStyle { get }
    /**
     Setter for modifying styles of a UPennControlStylable object
     - parameter styles: UPennControlStyle object with all the style for modification
     */
    func setStyles(_ styles: UPennControlStyle)
}

public extension UPennControlStylable {
    /**
     Builder method for getting and modifying the styling of a particular UPennControlStylable type
     - parameters:
        - type: UPennControlStylable Type from which to extract styles
        - styles: UPennControlStyle object with all the styles for modification
     */
    func getStyles<T:UPennControlStylable>(type: T.Type, styles: UPennControlStyle) -> UPennControlStyle {
        let parentStyles = type.GetStyle
        let moddedStyles = parentStyles.modify(with: styles)
        return moddedStyles
    }
}

