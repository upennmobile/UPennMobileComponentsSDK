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

public protocol UPennSettingsCoordinatorInterface : UPennCoordinator, UPennLogoutBiometricsDelegate { }

open class UPennSettingsCoordinator : UPennSettingsCoordinatorInterface {
    
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    var settingsCoordinatorDelegate : UPennLogoutBiometricsDelegate?
    public var childViewController: UIViewController?
    
    public init(
        navController: UINavigationController,
        settingsViewController: UIViewController,
        settingsCoordinatorDelegate: UPennLogoutBiometricsDelegate) {
        self.navigationController = navController
        self.childViewController = settingsViewController
        self.settingsCoordinatorDelegate = settingsCoordinatorDelegate
    }
    
    open func start() {
        
    }
    
    open func logout() {
        self.settingsCoordinatorDelegate?.logout()
    }
    
    open func toggleShouldAutoFill(_ enabled: Bool) {
        self.settingsCoordinatorDelegate?.toggleShouldAutoFill(enabled)
    }
}
