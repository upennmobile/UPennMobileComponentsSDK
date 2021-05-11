//
//  UPennMainCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/1/21.
//

import Foundation
import UIKit

public protocol UPennMainCoordinatable : UPennCoordinator, UPennLogoutBiometricsDelegate {
    var logoutBiometricsDelegate: UPennLogoutBiometricsDelegate?  { get set }
    func configureView()
}

open class UPennMainTabCoordinator : NSObject, UPennMainCoordinatable {
    public var childCoordinators: [UPennCoordinator] = [UPennCoordinator]()
    
    open var navigationController: UINavigationController
    
    open var childViewController: UIViewController?
    
    open var tabController : UITabBarController?
    open var logoutBiometricsDelegate : UPennLogoutBiometricsDelegate?
    
    public init(navController: UINavigationController, tabController: UITabBarController) {
        // TODO: Initializer should take in array of childCoordinators to facilitate dynamic building of tabBarControllers/Items
        self.navigationController = navController
        self.tabController = tabController
        self.childViewController = self.tabController
        super.init()
        self.tabController?.delegate = self
    }
    
    open func start() {
        // Configure View?
        
        self.configureView()
    }
    
    // MARK: - VC Factory Methods
    
    func makeViewController(identifier: String) -> UIViewController? {
//        let navVC = self.appDelegate?.storyboard.instantiateViewController(withIdentifier: identifier)
//        return navVC
        return UIViewController()
    }
    
    // TODO: Update to loop through array of childCoordinators and set tabController.viewControllers to each coord's childVC
    open func configureView() {
        // TODO: VC's should be instatiated outside this Coordinator, and only looping through childCoord's start() and set tabController.viewControllers here
        let settingsVC = UPennSettingsViewController.Instantiate(.SDK)
        let settingsCoord = UPennSettingsCoordinator(
            navController: self.navigationController,
            settingsViewController: settingsVC,
            settingsCoordinatorDelegate: self)
        settingsVC.settingsCoordinator = settingsCoord
        settingsCoord.start()
            self.tabController?.viewControllers = [
                UINavigationController(rootViewController: settingsCoord.childViewController!)
            ]
            self.tabController?.selectedIndex = 0
            self.configureTabBarItems()
    }
    
    open func configureTabBarItems() {
   
        // Set selected image & text tintColor
        self.tabController?.tabBar.tintColor = UIColor.black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.upennDeepBlue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.upennRlyLightGray], for: .normal)
        
        // Accounts
        let myTabBarItem4 = (self.tabController?.tabBar.items?[0])! as UITabBarItem
        myTabBarItem4.image = UPennImageAssets.AccountUnSelected.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.selectedImage = UPennImageAssets.AccountSelected.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.title = "Accounts"
    }
    
    open func logout() {
        // TODO: Fire delegates into MasterCoordinator to handle?
        self.logoutBiometricsDelegate?.logout()
    }
    
    open func toggleShouldAutoFill(_ enabled: Bool) {
        // TODO: Fire delegates into MasterCoordinator to handle?
        self.logoutBiometricsDelegate?.toggleShouldAutoFill(enabled)
    }
}

extension UPennMainTabCoordinator : UITabBarControllerDelegate { }
