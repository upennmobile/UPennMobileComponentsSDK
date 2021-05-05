//
//  UPennMainCoordinatable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/31/21.
//

import Foundation
import UIKit

open class UPennMasterCoordinator : UPennMasterCoordinatable {
    
    public var childViewController: UIViewController?
    
    
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    
    public init(navController: UINavigationController, childCoordinators: [UPennCoordinator]?=nil) {
        self.navigationController = navController
        if let coordinators = childCoordinators {
            self.childCoordinators = coordinators
        }
        self.childViewController = UIViewController()
        self.navigationController.makeParentViewController(self.childViewController!)
    }
    
    open func start() {
        self.loginCoordinator?.start()
        self.navigationController.navigationBar.isHidden = true
        self.showLogin()
    }
    
    open func dismissAndPresentLogout() {
        // Check if a viewController is presented, if not, show Auto-logout alert
        guard let presentedVC = self.navigationController.presentedViewController else {
            self.showLogoutAlert()
            return
        }
        
        // Check if the LoginViewController is presented, if not, show Auto-logout alert
        guard let _ = presentedVC as? UPennLoginViewController else {
            self.navigationController.dismiss(animated: true) {
                self.showLogoutAlert()
            }
            return
        }
    }
}

extension UPennMasterCoordinator : UPennLoginCoordinatorDelegate {
    
    public func didSuccessfullyLoginUser() {
        self.mainCoordinator?.logoutBiometricsDelegate = self
        self.showMainViewController()
        UPennTimerUIApplication.ResetIdleTimer()
    }
}

extension UPennMasterCoordinator : UPennLogoutBiometricsDelegate {
    public func logout() {
        // Tell LoginCoordinator to logout
        self.loginCoordinator?.logout()
        self.resetToLogin()
        UPennTimerUIApplication.InvalidateActiveTimer()
    }
    
    public func toggleShouldAutoFill(_ enabled: Bool) {
        // Tell LoginCoordinator to toggle AutoFill
        self.loginCoordinator?.presenter.toggleShouldAutoFill(enabled)
    }
}

private extension UPennMasterCoordinator {
    
    var loginCoordinator: UPennLoginCoordinator? {
        return self.getChildCoordinator(type: UPennLoginCoordinator.self)
    }
    
    var mainCoordinator: UPennMainCoordinator? {
        return self.getChildCoordinator(type: UPennMainCoordinator.self)
    }
    
    var loginViewController : UIViewController? {
        return loginCoordinator?.childViewController
    }
    
    var mainViewController : UIViewController? {
        return mainCoordinator?.childViewController
    }
    
    func resetToLogin() {
        self.showLogin()
    }
    
    func showMainViewController() {
        self.mainCoordinator?.start()
        self.childViewController?.swapParentViewController(
            fromVC: self.loginViewController,
            toVC: self.mainViewController!)
    }
    
    func showLoginVsMainTabViewController() {
        if let coord = loginCoordinator, coord.userIsLoggedIn {
            self.showMainViewController()
        } else {
            self.resetToLogin()
        }
    }
    
    @objc func swapLoginFromMainTabViewController() {
        /*
         * 1. Swap MainTabController in for LoginVC
         * 2. Remove Login Observer
         */
        // 1.
        self.showMainViewController()
        // 2.
        self.loginCoordinator?.removeLoginObserver()
    }
    
    func swapFromLoginToJoinViewController() {
        self.loginCoordinator?.removeLoginObserver()
        self.childViewController?.swapParentViewController(
            fromVC: loginViewController,
            toVC: mainViewController!)
    }
    
    func showLogin() {
        guard let loginVC = self.loginViewController else { return }
        loginCoordinator?.setLoginObserver()
        self.childViewController?.swapParentViewController(fromVC: self.mainViewController, toVC: loginVC)
    }
    
    func showLogoutAlert() {
        let logoutAlert = UPennAlertsPresenter.AutoLogoutAlert(logoutCallback: logout)
        self.navigationController.present(logoutAlert, animated: true, completion: nil)
    }
    
}
