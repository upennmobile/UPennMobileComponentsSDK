//
//  ViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by rabdulsal on 05/07/2021.
//  Copyright (c) 2021 rabdulsal. All rights reserved.
//

import UIKit
import UPennMobileComponentsSDK

class ExampleStartupCoordinator : UPennStartupCoordinator {
    
    override func start() {
        // Configure Activity Presenter
        UPennActivityPresenter.Configure()
        // Configure Auto-Logout Timer
        UPennTimerUIApplication.ConfigureAutoLogoutTimer(callback: self.applicationDidTimeout(notification:))
        
        // Make TabBarPayloads & MainTabCoordinator
        let vc1 = UPennSettingsViewController.Instantiate(.SDK)
//        let vc2 = UPennSettingsViewController.Instantiate(.SDK)
        // MainTab Child Coord's
        let settingsVC = UPennSettingsViewController.Instantiate(.SDK)
        let settingsCoord = UPennSettingsCoordinator(
            navController: self.navigationController,
            settingsViewController: settingsVC)
        settingsVC.settingsCoordinator = settingsCoord
        
        let navControllers = [UINavigationController(rootViewController: vc1), UINavigationController(rootViewController: settingsVC)]
        let tabItem = UPennTabBarItem(title: "Scan".localize, selectedImage: UIImage(systemName: "camera.fill"), unselectedImage: UIImage(systemName: "camera"))
        let tabItems = [
            tabItem,
            UPennSettingsCoordinator.TabBarItem
            ]
        let payload = UPennTabControllerPayload(navControllers: navControllers, tabBarItems: tabItems)
        
//        settingsCoord.start()
        
        // MainTab Coord
        let mainCoordinator = UPennMainTabCoordinator(navController: self.navigationController, tabControllerPayload: payload)
        settingsCoord.logoutBiometricsDelegate = mainCoordinator
        
        UPennMainTabCoordinator.TabBarTintColor = UIColor.upennDeepBlue
        
        
        // Make Login VC & Coordinator
        let childVC = UPennLoginViewController.Instantiate(.SDK)
        // Make Login presenter
        let presenter = UPennLoginPresenter(loginDelegate: childVC)
        // Make LoginCoordinator
        let loginCoordinator = UPennLoginCoordinator(navController: self.navigationController, childViewController: childVC, presenter: presenter)
        // Set LoginVC presenter
        childVC.presenter = presenter
        // Set LoginVC coordinator
        childVC.coordinator = loginCoordinator
        // Set MasterCoordinator
        self.masterCoordinator = UPennMasterCoordinator(navController: self.navigationController, childCoordinators: [loginCoordinator,mainCoordinator])
        // Set LoginCoord delegate
        loginCoordinator.loginCoordinatorDelegate = self.masterCoordinator
        mainCoordinator.logoutBiometricsDelegate = masterCoordinator
        // Start MasterCoord
        self.masterCoordinator?.start()
        // Startup Callback
        super.start()
    }
}

extension ExampleStartupCoordinator : UPennAppTimeoutDelegate {
    // Callback for when the timeout was fired.
    open func applicationDidTimeout(notification: NSNotification) {
        self.masterCoordinator?.dismissAndPresentLogout()
    }
}

