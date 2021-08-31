//
//  UPennActivityPresenter.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/7/21.
//

import Foundation
import SVProgressHUD

open class UPennActivityPresenter {
    
    public static func Configure(
        foreGroundColor: UIColor?=nil,
        dismissTimeInterval: Double?=3.0) {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(foreGroundColor ?? UIColor.upennMediumBlue)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMaximumDismissTimeInterval(dismissTimeInterval ?? 3.0)
    }
    
    /// Dismiss custom Activity Spinner
    public static func Dismiss() {
        SVProgressHUD.dismiss()
    }
    
    /// Show custom Activity Spinner
    public static func Show() {
        SVProgressHUD.show()
    }
    
    /// Show custom Activity Spinner with custom message
    public static func Show(message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    /// Show custom Success Alert with custom message
    public static func ShowSuccess(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    /// Show custom Error Alert with custom message
    public static func ShowError(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
}
