//
//  Storyboarded.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/24/21.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func Instantiate() -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func Instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
