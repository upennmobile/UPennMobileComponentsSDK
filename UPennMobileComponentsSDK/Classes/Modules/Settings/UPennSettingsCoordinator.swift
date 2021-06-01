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

open class UPennSettingsCoordinator : UPennSettingsCoordinatorInterface, UPennTabBarItemed {
    
    public static var TabBarItem: UPennTabBarItem = UPennTabBarItem(title: "Account".localize, selectedImage: UIImage(systemName: "person.circle.fill"), unselectedImage: UIImage(systemName: "person.circle"))
    
    
    public var childCoordinators = [UPennCoordinator]()
    public var navigationController: UINavigationController
    public var logoutBiometricsDelegate : UPennLogoutBiometricsDelegate?
    public var childViewController: UIViewController?
    
    public init(
        navController: UINavigationController,
        settingsViewController: UIViewController) {
        self.navigationController = navController
        self.childViewController = settingsViewController
    }
    
    open func start() {
        
    }
    
    open func logout() {
        self.logoutBiometricsDelegate?.logout()
    }
    
    open func toggleShouldAutoFill(_ enabled: Bool) {
        self.logoutBiometricsDelegate?.toggleShouldAutoFill(enabled)
    }
}
