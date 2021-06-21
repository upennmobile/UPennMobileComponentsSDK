//
//  UPennCellIdentifiable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation

public protocol UPennCellIdentifiable { }

extension UPennCellIdentifiable {
    public static var Identifier: String {
        return String(describing: self)
    }
}
