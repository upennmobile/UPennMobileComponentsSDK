//
//  UPennLoginCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation
import UIKit
//import UPennMobileComponentsSDK

public protocol UPennLoginCoordinated : UPennLoginCoordinatable, UPennCoordinator {
    var presenter : UPennLoginPresentable { get set }
    func setLoginObserver()
    func removeLoginObserver()
    func sendLoginNotification()
    /// Handler fired when a User successfully logs in
    func handleLoginNotification()
}
/**
 Abstract:
 Purpose of this LoginCoordinator is to act as a Facade between any custom LoginViewController and behavioral protocols for logging-in and optionally using biometrics
 */
open class UPennLoginCoordinator : UPennLoginCoordinated {
    public var childViewController: UIViewController?
    
    
    static var IsLoggedInNotification = "UPHSIsLoggedInNotification"
    open var childCoordinators = [UPennCoordinator]()
    open var navigationController: UINavigationController
    open var loginCoordinatorDelegate : UPennLoginCoordinatorDelegate?
    open var presenter : UPennLoginPresentable

    // MARK: - LoginService
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
        // TODO: Dependency-inject vc as 'childViewController' with protocol type of 'UPennLoginPresented' that includes presenter and coordinator vars
        let vc = UPennLoginViewController.Instantiate(.SDK)
        self.childViewController = /*vc*/ UINavigationController(rootViewController: vc)
        self.presenter = UPennLoginPresenter(loginDelegate: vc)
        vc.loginPresenter = self.presenter
        vc.loginCoordinator = self
    }
    
    open func start() {
    }
    
    open func setLoginObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleLoginNotification), name: NSNotification.Name.init(Self.IsLoggedInNotification), object: nil)
    }
    
    open func removeLoginObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
    open func sendLoginNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
    /// Handler fired when a User successfully logs in
    @objc open func handleLoginNotification() {
        if presenter.isFirstLogin {
            presenter.setFirstLogin()
        }
    }
    
    // MARK: UPennLoginCoordinatable
       
   open var userIsLoggedIn: Bool { return UPennAuthenticationService.IsAuthenticated }
   
   open func logout() {
       UPennAuthenticationService.logout()
   }
}

extension UPennLoginCoordinator : UPennLoginCoordinatorDelegate {
    
    open func didSuccessfullyLoginUser() {
        self.sendLoginNotification()
        self.loginCoordinatorDelegate?.didSuccessfullyLoginUser()
    }
}

private extension UPennLoginCoordinator {
    
    
}
