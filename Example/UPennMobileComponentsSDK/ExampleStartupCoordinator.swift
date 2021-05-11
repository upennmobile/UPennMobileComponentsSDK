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
        let mainCoordinator = UPennMainTabCoordinator(navController: self.navigationController, tabController: UPennTabBarController.Instantiate(.SDK))
        // Make Login ChildVC
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

