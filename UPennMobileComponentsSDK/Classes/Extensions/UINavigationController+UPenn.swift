//
//  UINavigationController+UPenn.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/10/21.
//

import Foundation
import UIKit

public extension UINavigationController {
    
    @objc func popToRoot(_ delay: Double=0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
            self.popToRootViewController(animated: true)
        }
    }
}
