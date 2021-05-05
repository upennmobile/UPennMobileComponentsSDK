//
//  UPennLoginCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation
import UIKit
//import UPennMobileComponentsSDK

/**
 Abstract:
 Purpose of this LoginCoordinator is to act as a Facade between any custom LoginViewController and behavioral protocols for logging-in and optionally using biometrics
 */
public class UPennLoginCoordinator : UPennCoordinator {
    public var childViewController: UIViewController?
    
    
    static var IsLoggedInNotification = "UPHSIsLoggedInNotification"
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    public var loginCoordinatorDelegate : UPennLoginCoordinatorDelegate?
    public var presenter : UPennLoginPresenter

    // MARK: - LoginService
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
        let vc = UPennLoginViewController.Instantiate(.SDK)
        // TODO: Dependency-inject LoginVC values like loginPresenter
        self.childViewController = /*vc*/ UINavigationController(rootViewController: vc)
        self.presenter = UPennLoginPresenter(loginDelegate: vc)
        vc.loginPresenter = self.presenter
        vc.loginCoordinator = self
    }
    
    public func start() {
        // Checks Authentication & conditionally instantiates & presents LoginVC as needed? -- start() will likely be called by a MainCoordinator class in the AppDelegate
        // Sets LoginVC as Coordinator's delegate?
//        let vc = UPennLoginViewController.Instantiate(.SDK)
//        // TODO: Dependency-inject LoginVC values like loginPresenter
//        self.presenter = UPennLoginPresenter(loginDelegate: vc)
//        vc.loginPresenter = self.presenter
//        vc.loginCoordinator = self
//        navigationController.pushViewController(vc, animated: false)
//        navigationController.title = "Sign In"
    }
    
    public func setLoginObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleLoginNotification), name: NSNotification.Name.init(Self.IsLoggedInNotification), object: nil)
    }
    
    public func removeLoginObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
}

extension UPennLoginCoordinator : UPennLoginCoordinatable {
    
    public var userIsLoggedIn: Bool { return UPennAuthenticationService.IsAuthenticated }
    
    public func logout() {
        /*
         * 1. Turn off logout timer
         * 2. Logout
         * 3. Reload to Login flow via UPennRootViewController
         */
//        UPennTimerUIApplication.invalidateActiveTimer()
//        self.invalidateAuthToken()
//        self.rootViewController?.resetToLogin()
        UPennAuthenticationService.logout()
    }
}

extension UPennLoginCoordinator : UPennLoginCoordinatorDelegate {
    
    public func didSuccessfullyLoginUser() {
        self.sendLoginNotification()
        self.loginCoordinatorDelegate?.didSuccessfullyLoginUser()
    }
}

private extension UPennLoginCoordinator {
    
    func sendLoginNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Self.IsLoggedInNotification), object: nil)
    }
    
    /// Handler fired when a User successfully logs in
    @objc func handleLoginNotification() {
        if presenter.isFirstLogin {
            presenter.setFirstLogin()
        }
//        self.checkOnboarding()
    }
}
