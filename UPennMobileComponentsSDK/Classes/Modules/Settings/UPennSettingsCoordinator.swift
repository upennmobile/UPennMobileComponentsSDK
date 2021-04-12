//
//  UPennSettingsCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/30/21.
//

import Foundation

public protocol UPennLogoutBiometricsDelegate {
    func logout()
    func toggleShouldAutoFill(_ enabled: Bool)
}

public class UPennSettingsCoordinator : UPennCoordinator {
    
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    var settingsCoordinatorDelegate : UPennLogoutBiometricsDelegate?
    public var childViewController: UIViewController?
    
    public init(navController: UINavigationController, settingsCoordinatorDelegate: UPennLogoutBiometricsDelegate) {
        self.navigationController = navController
//        self.visibleViewController = self.navigationController.visibleViewController!
        self.settingsCoordinatorDelegate = settingsCoordinatorDelegate
    }
    
    public func start() {
        let settingsVC = UPennSettingsViewController.Instantiate(.SDK)
        settingsVC.settingsCoordinator = self
        self.childViewController = settingsVC
//        navigationController.pushViewController(settingsVC, animated: false)
    }
    
}

extension UPennSettingsCoordinator : UPennLogoutBiometricsDelegate {
    
    public func logout() {
        // Fire logout in MainCoordinator?
        print("Logout PRessed!")
        self.settingsCoordinatorDelegate?.logout()
    }
    
    public func toggleShouldAutoFill(_ enabled: Bool) {
        // TODO: Which delegate method to fire?
        print("'Should Autofill' Pressed!")
        self.settingsCoordinatorDelegate?.toggleShouldAutoFill(enabled)
    }
}
