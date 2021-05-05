//
//  UPennMainCoordinatable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/31/21.
//

import Foundation
import UIKit

open class UPennMasterCoordinator : UPennMasterCoordinatable {
    
    open var loginCoordinator: UPennLoginCoordinated?
    open var mainCoordinator: UPennMainCoordinatable?
    open var childViewController: UIViewController?
    open var childCoordinators = [UPennCoordinator]()
    open var navigationController: UINavigationController
    
    open var loginViewController : UIViewController? {
        return loginCoordinator?.childViewController
    }
    
    open var mainViewController : UIViewController? {
        return mainCoordinator?.childViewController
    }
    
    public init(navController: UINavigationController, childCoordinators: [UPennCoordinator]?=nil) {
        self.navigationController = navController
        if let coordinators = childCoordinators {
            self.childCoordinators = coordinators
            self.loginCoordinator = self.getChildCoordinator(type: UPennLoginCoordinator.self)
            self.mainCoordinator = self.getChildCoordinator(type: UPennMainTabCoordinator.self)
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
    
    open func showMainViewController() {
        self.mainCoordinator?.start()
        self.childViewController?.swapParentViewController(
            fromVC: self.loginViewController,
            toVC: self.mainViewController!)
    }
    
    open func showLoginVsMainViewController() {
        if let coord = loginCoordinator, coord.userIsLoggedIn {
            self.showMainViewController()
        } else {
            self.showLogin()
        }
    }
    
    @objc open func swapLoginFromMainViewController() {
        /*
         * 1. Swap MainTabController in for LoginVC
         * 2. Remove Login Observer
         */
        // 1.
        self.showMainViewController()
        // 2.
        self.loginCoordinator?.removeLoginObserver()
    }
    
    open func swapFromLoginToJoinViewController() {
        self.loginCoordinator?.removeLoginObserver()
        self.childViewController?.swapParentViewController(
            fromVC: loginViewController,
            toVC: mainViewController!)
    }
    
    open func showLogin() {
        guard let loginVC = self.loginViewController else { return }
        loginCoordinator?.setLoginObserver()
        self.childViewController?.swapParentViewController(fromVC: self.mainViewController, toVC: loginVC)
    }
    
    open func showLogoutAlert() {
        let logoutAlert = UPennAlertsPresenter.AutoLogoutAlert(logoutCallback: logout)
        self.navigationController.present(logoutAlert, animated: true, completion: nil)
    }


// MARK: UPennLoginCoordinatorDelegate
    
    open func didSuccessfullyLoginUser() {
        self.mainCoordinator?.logoutBiometricsDelegate = self
        self.showMainViewController()
        UPennTimerUIApplication.ResetIdleTimer()
    }

// MARK: UPennLogoutBiometricsDelegate
    open func logout() {
        // Tell LoginCoordinator to logout
        self.loginCoordinator?.logout()
        self.showLogin()
        UPennTimerUIApplication.InvalidateActiveTimer()
    }
    
    open func toggleShouldAutoFill(_ enabled: Bool) {
        // Tell LoginCoordinator to toggle AutoFill
        self.loginCoordinator?.presenter.toggleShouldAutoFill(enabled)
    }
}
