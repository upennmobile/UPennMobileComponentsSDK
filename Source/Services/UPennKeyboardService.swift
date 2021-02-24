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
    
    weak fileprivate var scrollView:UIScrollView?
    
    weak fileprivate var parentView: UIView?
    
    public init(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    public init(_ view: UIView) {
        self.parentView = view
    }
    
    public func beginObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(UPennKeyboardService.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UPennKeyboardService.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    public func endObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc public func keyboardWillShow(_ notif:Notification) {
//        if let keyboardFrame = (notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
//            let contentInsets = UIEdgeInsets(top: scrollView!.contentInset.top, left: 0, bottom: keyboardFrame.height, right: 0)
//            scrollView!.contentInset = contentInsets
//            scrollView!.scrollIndicatorInsets = contentInsets
//        }
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.parentView!.frame.origin.y == 0{
                self.parentView!.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc public func keyboardDidHide(_ notif:Notification) {
//        let contentInset = UIEdgeInsets(top: scrollView!.contentInset.top, left: 0, bottom: 0, right: 0)
//        scrollView!.contentInset = contentInset
//        scrollView!.scrollIndicatorInsets = contentInset
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.parentView!.frame.origin.y != 0{
                self.parentView!.frame.origin.y += keyboardSize.height
            }
        }
    }
    
}
