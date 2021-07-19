//
//  UPennImageLabelSwitchDecorator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/9/21.
//

import Foundation
import UIKit

/// Interface for constructing an object to decorate the attributes of a UPennImageLabelSwitchView
public protocol UPennImageLabelSwitchControlDecorated {
    var title: String { get }
    var image: UIImage { get }
    var delegate: UPennSwitchControlDelegate? { get }
    var isEnabled: Bool { get }
    var isSelected: Bool { get }
    var styles: UPennControlStyle? { get }
}

/// Struct intended for conviently decorating the attributes of a UPennImageLabelSwitchView
public struct UPennImageLabelSwitchDecorator : UPennImageLabelSwitchControlDecorated {
    
    public var title: String
    public var image: UIImage
    public weak var delegate: UPennSwitchControlDelegate?
    public var isEnabled: Bool
    public var isSelected: Bool
    public var styles: UPennControlStyle?

    public init(
        title: String,
        image: UIImage,
        delegate: UPennSwitchControlDelegate?,
        enabled: Bool,
        selected: Bool,
        styles: UPennControlStyle?=nil
    ) {
        self.title = title
        self.image = image
        self.delegate = delegate
        self.isSelected = selected
        self.isEnabled = enabled
        self.styles = styles
    }
    
}
