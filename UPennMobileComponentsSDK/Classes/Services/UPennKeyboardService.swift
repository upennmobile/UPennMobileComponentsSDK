//
//  UPennKeyboardService.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/13/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit

public class UPennKeyboardService: NSObject {
    static fileprivate let KEYBOARD_BUFFER: CGFloat = 160.0
    
    weak fileprivate var scrollView:UIScrollView?
    
    fileprivate var parentView: UIView
    fileprivate var keyboardBoundingObject: UIView
    fileprivate var shiftedDistance: CGFloat = 0.0
    fileprivate var screenHasShifted: Bool {
        return self.shiftedDistance != 0.0
    }
    
    public init(_ view: UIView, _ boundingObject: UIView) {
        self.keyboardBoundingObject = boundingObject
        self.parentView = view
    }
    
    public func beginObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(UPennKeyboardService.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UPennKeyboardService.keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    public func endObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc public func keyboardDidShow(_ notif:Notification) {
        // If screen hasn't already shifted, shift screen up
        if let keyboardSize = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !self.screenHasShifted {
                UIView.animate(withDuration: 0.3) {
                    self.parentView.frame.origin.y -= self.calculateScreenShift(self.screenToKeyboardDist(keyboardSize))
                }
            }
        }
    }
    
    @objc public func keyboardDidHide(_ notif:Notification) {
        // If screen has been shifted, shift screen back down
        if self.screenHasShifted {
            UIView.animate(withDuration: 0.3) {
                self.parentView.frame.origin.y += self.shiftedDistance
                self.shiftedDistance = 0.0
            }
        }
    }
}

private extension UPennKeyboardService {
    
    /// Get the distance from the top of the Screen to the bottom of the Login button
    var screenToLoginBottomDist : CGFloat {
        return self.keyboardBoundingObject.frame.origin.y + self.keyboardBoundingObject.frame.size.height
    }
    
    /**
     Get the distance from the top of the Screen to the top of the Keyboard
     - parameter keyboardRect: Frame Rect for the visible Keyboard
     */
    func screenToKeyboardDist(_ keyboardRect: CGRect) -> CGFloat {
        return keyboardRect.origin.y - Self.KEYBOARD_BUFFER
    }
    
    /**
     Calculate the distance to shift the screen on Keyboard appearance using distance-delta between top of Keyboard and bottom of Login button
     - parameter screenToLeyboardDist: Represents the distance from top of the screen to top of the Keyboard
     */
    func calculateScreenShift(_ screenToKeyboardDist: CGFloat) -> CGFloat {
        
        let loginToKeyboardDelta = screenToKeyboardDist - self.screenToLoginBottomDist
        if loginToKeyboardDelta < 20.0 {
            self.shiftedDistance = 20.0 - loginToKeyboardDelta
            return self.shiftedDistance
        }
        return 0.0
    }
}
