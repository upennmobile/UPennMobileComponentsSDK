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
    
    static var IsLoggedInNotification = "UPHSIsLoggedInNotification"
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    var loginCoordinatorDelegate : UPennLoginCoordinatorDelegate?

    // MARK: - LoginService
    
    public init(navController: UINavigationController, coordinatorDelegate: UPennLoginCoordinatorDelegate) {
        self.navigationController = navController
        self.loginCoordinatorDelegate = coordinatorDelegate
    }
    
    public func start() {
        // Checks Authentication & conditionally instantiates & presents LoginVC as needed? -- start() will likely be called by a MainCoordinator class in the AppDelegate
        // Sets LoginVC as Coordinator's delegate?
        let vc = UPennLoginViewController.Instantiate(.SDK) 
        // TODO: Dependency-inject LoginVC values like loginPresenter
        vc.loginPresenter = UPennLoginPresenter(loginDelegate: vc)
        vc.loginCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
//    func makeLoginRequest(username: String, password: String) {
//        self.loginService?.makeLoginRequest(username: username, password: password)
//    }
//
//    func attemptSilentLogin() {
//        self.loginService?.attemptSilentLogin()
//    }
//
//    func authenticationAutoFillCheck() {
//        self.loginService?.authenticationAutoFillCheck()
//    }
//
//    func toggleShouldAutoFill(_ autoFill: Bool) {
//        self.loginService?.toggleShouldAutoFill(autoFill)
//    }
//
//    var isFirstLogin: Bool { return self.loginService?.isFirstLogin ?? false }
//
//    func setFirstLogin() {
//        self.loginService?.setFirstLogin()
//    }
//
//    func cacheLoginCredentials(username: String, password: String) {
//        self.loginService?.cacheLoginCredentials(username: username, password: password)
//    }
    
    // MARK: - Logout
    
    
    
//    func invalidateAuthToken() {
//        self.loginService?.logout()
//    }
    
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
}

//extension UPennLoginCoordinator : UPennLoginServiceDelegate {
//    func didSuccessfullyLoginUser(_ username: String) {
//        // Inform Parent Coordinator?
//    }
//
//    func didReturnAutoFillCredentials(username: String, password: String) {
//        // Pass to some Login ViewController
//    }
//
//    func didFailToLoginUser(errorStr: String) {
//        // Inform Parent Coordinator?
//    }
//
//
//}
