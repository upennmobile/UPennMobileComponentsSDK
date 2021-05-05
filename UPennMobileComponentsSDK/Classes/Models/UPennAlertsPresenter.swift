//
//  UPennAlertsPresenter.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/18/21.
//

import Foundation

/**
 Abstract:
    Struct designed to hold all content Strings needed to populate TouchID Opt-in AlertController
 */
open class UPennTouchIDFieldContent {
    open var optInTitle,optInMessage,declinedMessage,confirmedMessage: String
    
    public init(title: String, message: String, declined: String, confirmed: String) {
        self.optInTitle = title; optInMessage = message; declinedMessage = declined; confirmedMessage = confirmed
    }
}

/**
 Abstract:
    Struct that manages presenting all AlertControllers.
    Sub-class this
 */
open class UPennAlertsPresenter {
    public enum TouchIDUseSelection : Int {
        case Cancel, Use
    }
    public static func TouchIDAlertController(content: UPennTouchIDFieldContent, touchIDCallback: @escaping (_ touchIDSelection: TouchIDUseSelection)->Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: content.optInTitle,
            message: content.optInMessage,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: content.declinedMessage, style: .cancel, handler: {
            alert -> Void in
            // Fire .Cancel callback
            touchIDCallback(.Cancel)
        })
        let useTouchIDAction = UIAlertAction(title: content.confirmedMessage, style: .default, handler: {
            alert -> Void in
            // Fire .Use callback
            touchIDCallback(.Use)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(useTouchIDAction)
        return alertController
    }
    
    public static func RememberMeAlertController(biometricsOptOutMessage: String, callback: @escaping ()->Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: biometricsOptOutMessage,
            message: "",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil)
        let disableRememberMe = UIAlertAction(title: "OK".localize, style: .default, handler: {
            alert -> Void in
//            Fire callback
            callback()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(disableRememberMe)
        return alertController
    }
    
    public static func AutoLogoutAlert(logoutCallback: @escaping ()->Void) -> UIAlertController {
        let alertController = UIAlertController(title: "You've Been Logged-out".localize, message: "For security purposes you've been automatically logged-out due to inactivity. Please log back in.".localize, preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Login", style: .cancel, handler: {
            alert -> Void in
//          Fire logoutCallback
            logoutCallback()
        })
        alertController.addAction(logoutAction)
        return alertController
    }
    
}
