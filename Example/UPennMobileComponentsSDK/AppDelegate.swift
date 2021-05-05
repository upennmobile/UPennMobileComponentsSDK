//
//  AppDelegate.swift
//  UPennMobileComponentsSDK
//
//  Created by rabdulsal on 02/22/2021.
//  Copyright (c) 2021 rabdulsal. All rights reserved.
//

import UIKit
import UPennMobileComponentsSDK

class PCLNetworkingService : UPennApplicationSettings {
    
    func thing() {
        
    }
}

class ExMasterCoordinator : UPennMasterCoordinator {
    func thing() {
        let foo = self.childCoordinators
    }
}

@objc protocol UPennAppTimeoutDelegate {
    @objc func applicationDidTimeout(notification: NSNotification)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var masterCoordinator: UPennMasterCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
         TODO: Initialize an Authentication Coordinator to manage checking User login state, and login/logout
         */
        UPennActivityPresenter.Configure()
        let navController = UINavigationController()
        let mainCoordinator = UPennMainCoordinator(navController: navController)
        let loginCoordinator = UPennLoginCoordinator(navController: navController)
        self.masterCoordinator = UPennMasterCoordinator(navController: navController, childCoordinators: [loginCoordinator,mainCoordinator])
        loginCoordinator.loginCoordinatorDelegate = masterCoordinator
        self.masterCoordinator?.start()
        
        // Configure Auto-Logout Timer
        UPennTimerUIApplication.ConfigureAutoLogoutTimer(callback: self.applicationDidTimeout(notification:))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: Application Lifecycle

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - Timeout Notification

extension AppDelegate : UPennAppTimeoutDelegate {
    // Callback for when the timeout was fired.
    func applicationDidTimeout(notification: NSNotification) {
        self.masterCoordinator?.dismissAndPresentLogout()
    }
}

