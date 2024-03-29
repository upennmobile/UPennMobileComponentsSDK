//
//  UIView+UPenn.swift
//  ScanFail
//
//  Created by Rashad Abdul-Salam on 8/7/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /**
     Base animation function with set values for animation interaction
     - parameter callback: Optional block of code to run during 'animations' block
     */
    static func BasicAnimation(callback: (()->Void)?) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: [],
            animations: {
                callback?()
        }, completion: nil)
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
