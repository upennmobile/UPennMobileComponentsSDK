//
//  UPennLoginCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/23/21.
//

import Foundation
import UIKit

public protocol UPennLoginCoordinated : UPennLoginCoordinatable, UPennCoordinator {
    var coordinatorDelegate : UPennLoginCoordinatorDelegate? { get set }
    var presenter : UPennLoginPresentable { get set }
    func setLoginObserver()
    func removeLoginObserver()
    func sendLoginNotification()
    /// Handler fired when a User successfully logs in
    func handleLoginNotification()
}

public protocol UPennLoginViewControllable : UPennLoginPresenterDelegate {
    var username: String { get set }
    var password: String { get set }
    var presenter: UPennLoginPlusBiometricsInterface! { get set }
    var coordinator: UPennLoginCoordinatorDelegate! { get set }
    var textFieldManager : UPennValidationService { get set }
    func forgotPassword()
    var biometricsEnabled : Bool { get }
    var biometricsImage : UIImage { get }
    var shouldAutoFill : Bool { get }
    func toggleShouldAutoFill(_ autoFill: Bool)
    func presentRememberMeAlert()
    func attemptBiometricsAuthentication()
}
/**
 Abstract:
 Purpose of this LoginCoordinator is to act as a Facade between any custom LoginViewController and behavioral protocols for logging-in and optionally using biometrics
 */
open class UPennLoginCoordinator : UPennLoginCoordinated {
    
    public var childViewController: UIViewController?
    open var childCoordinators = [UPennCoordinator]()
    open var navigationController: UINavigationController
    open var coordinatorDelegate : UPennLoginCoordinatorDelegate?
    open var presenter : UPennLoginPresentable

    // MARK: - LoginService
    
    public init(
        navController: UINavigationController,
        childViewController: UIViewController,
        presenter: UPennLoginPresentable)
    {
        self.navigationController = navController
        self.childViewController = UINavigationController(rootViewController: childViewController)
        self.presenter = presenter
    }
    
    open func start() {
    }
    
    open func setLoginObserver() {
        UPennNotificationManager.SetLoginObserver(self, selector: #selector(self.handleLoginNotification))
    }
    
    open func removeLoginObserver() {
        UPennNotificationManager.RemoveLoginObserver(self)
    }
    
    open func sendLoginNotification() {
        UPennNotificationManager.SendLoginNotification()
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
        self.coordinatorDelegate?.didSuccessfullyLoginUser()
    }
}
