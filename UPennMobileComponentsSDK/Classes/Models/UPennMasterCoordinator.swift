//
//  UPennMainCoordinatable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/31/21.
//

import Foundation
import UIKit

public class UPennMasterCoordinator : UPennMasterCoordinatable {
    
    public var childViewController: UIViewController?
    
    
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    
    public init(navController: UINavigationController, childCoordinators: [UPennCoordinator]?=nil) {
        self.navigationController = navController
//        self.visibleViewController = self.navigationController.visibleViewController!
//        self.mainCoordinator = UPennMainCoordinator(navController: self.navigationController)
//        self.loginCoordinator = UPennLoginCoordinator(navController: self.navigationController)
        if let coordinators = childCoordinators {
            self.childCoordinators = coordinators
        }
//        self.loginCoordinator?.loginCoordinatorDelegate = self
        self.childViewController = UIViewController()
        self.navigationController.makeParentViewController(self.childViewController!)
//        self.navigationController.navBarSetup()
        // TODO: Add Child Coordinators for MainApp and LoginUX
    }
    
    public func start() {
        // Start LoginCoordinator?
//        self.loginCoordinator = UPennLoginCoordinator(navController: self.navigationController, coordinatorDelegate: self)
//        self.childCoordinators.append(loginCoordinator)
//        self.mainCoordinator = UPennMainCoordinator(navController: self.navigationController)
//        self.childCoordinators.append(settingsCoordinator)
//        let vc = UIViewController()
//        vc.view.frame = CGRect(x: 0.0, y: 0.0, width: UPennScreenGlobals.Width, height: UPennScreenGlobals.Height)
//        self.childViewController = self.navigationController.viewControllers.first
        self.loginCoordinator?.start()
//        self.childViewController?.title = "Sign In" /*loginCoordinator.childViewController?.title*/
        self.navigationController.navigationBar.isHidden = true
//        self.childViewController?.makeParentViewController(loginVC)
        self.showLogin()
    }
    
    public func dismissAndPresentLogout() {
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
        // TODO: Swap from LoginVC to MainVC
//        guard
//            let settingsCoord = childCoordinators.filter({ $0 is UPennSettingsCoordinator }).first,
//            let loginCoord = childCoordinators.filter({ $0 is UPenn}) {
//            return
//        }
        self.mainCoordinator?.logoutBiometricsDelegate = self
//        self.mainCoordinator.start()
        self.showMainViewController()
        UPennTimerUIApplication.ResetIdleTimer()
    }
}

extension UPennMasterCoordinator : UPennLogoutBiometricsDelegate {
    public func logout() {
        // Tell LoginCoordinator to logout
        self.loginCoordinator?.logout()
        // Swap-in LoginVC for MainVC
//        self.childViewController?.swapParentViewController(fromVC: mainViewController, toVC: loginViewController)
        self.resetToLogin()
        UPennTimerUIApplication.InvalidateActiveTimer()
    }
    
    public func toggleShouldAutoFill(_ enabled: Bool) {
        // Tell LoginCoordinator to toggle AutoFill
        self.loginCoordinator?.presenter.toggleShouldAutoFill(enabled)
    }
}

private extension UPennMasterCoordinator {
    
    var logoutAlertController : UIAlertController {
        let alertController = UIAlertController(title: "You've Been Logged-out".localize, message: "For security purposes you've been automatically logged-out due to inactivity. Please log back in.".localize, preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Login", style: .cancel, handler: {
            alert -> Void in
            self.logout()
        })
        alertController.addAction(logoutAction)
        return alertController
    }
    
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
//        if let _ = self.presentedViewController {
//            self.dismiss(animated: true) {
//                self.showLogin()
//            }
//            return
//        }
        self.showLogin()
    }
    
    func showMainViewController() {
//        SVProgressHUD.show(withStatus: "Getting your info...")
//        self.makeTabBarControllers()
        self.mainCoordinator?.start()
        // NOTE: Move to errorDelegate success/fail callback
        self.childViewController?.swapParentViewController(
            fromVC: self.loginViewController,
            toVC: self.mainViewController!)
//        self.navigationController.navigationBar.isHidden = true
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
//        self.navigationController.navigationBar.isHidden = false
    }
    
    func showLogoutAlert() {
        // TODO: Update what must be fired
//        self.appDelegate?.invalidateAuthToken()
        let logoutAlert = UPennAlertsPresenter.AutoLogoutAlert(logoutCallback: logout)
        self.navigationController.present(logoutAlert, animated: true, completion: nil)
    }
    
}
