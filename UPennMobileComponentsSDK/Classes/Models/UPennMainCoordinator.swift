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
    public static var TabBarSelectedColor: UIColor = UIColor.upennDeepBlue
    public static var TabBarUnSelectedColor: UIColor = UIColor.upennRlyLightGray
    public static var TabBarTintColor: UIColor = UIColor.black
    public static var StartIndex = 0
    
    open var childCoordinators: [UPennCoordinator] = [UPennCoordinator]()
    
    open var navigationController: UINavigationController
    
    open var childViewController: UIViewController?
    open var tabControllerPayload: UPennTabControllerPayload
    open var tabController = UITabBarController()
    open var logoutBiometricsDelegate : UPennLogoutBiometricsDelegate?
    
    public init(navController: UINavigationController, tabControllerPayload: UPennTabControllerPayload) {
        self.navigationController = navController
        self.childViewController = self.tabController
        self.tabControllerPayload = tabControllerPayload
        super.init()
        self.tabController.delegate = self
    }
    /// Set tabControllers base appearance
    open func start() {
        // Set selected image & text tintColor
        self.tabController.tabBar.tintColor = UPennMainTabCoordinator.TabBarTintColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UPennMainTabCoordinator.TabBarSelectedColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UPennMainTabCoordinator.TabBarUnSelectedColor], for: .normal)
        self.startCoordinators()
        self.configureView()
    }
    
    // MARK: - VC Factory Methods
    
    /// Loops through all child coordinators and runs their 'start' function
    open func startCoordinators() {
        for coord in self.childCoordinators {
            coord.start()
        }
    }
    
    /// Sets tabController child viewControllers to tabControllerPayload navigationControllers; sets selectedIndex and configures tabBar Items
    open func configureView() {
        // Set TabControllers
        self.tabController.viewControllers = self.tabControllerPayload.navControllers
        // Set Starting Index
        self.tabController.selectedIndex = UPennMainTabCoordinator.StartIndex
        // Configure TabBarItems
        self.configureTabBarItems()
    }
    
    /// Loops through tabControllerPayload tabBarItes, and sets all tabController tabItem attributes
    open func configureTabBarItems() {
    
        for (idx,item) in self.tabControllerPayload.tabBarItems.enumerated() {
            let tabItem = (self.tabController.tabBar.items?[idx])! as UITabBarItem
            tabItem.image = item.unSelectedImage
            tabItem.selectedImage = item.selectedImage
            tabItem.title = item.title
        }
    }
    
    open func logout() {
        self.logoutBiometricsDelegate?.logout()
    }
    
    open func toggleShouldAutoFill(_ enabled: Bool) {
        self.logoutBiometricsDelegate?.toggleShouldAutoFill(enabled)
    }
}

extension UPennMainTabCoordinator : UITabBarControllerDelegate { }
