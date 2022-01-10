//
//  UPennStartupCoordinator.swift
//  UPennMobileComponentsSDK-UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 5/7/21.
//

import Foundation
import UIKit

public protocol UPennStartupCoordinatorDelegate {
    func configureStartup()
}

/// Coordinator to manage/encapsulate various processes intended for application startup
open class UPennStartupCoordinator : UPennCoordinator {
    open var childCoordinators = [UPennCoordinator]()
    open var masterCoordinator: UPennMasterCoordinatable?
    open var navigationController: UINavigationController
    open var childViewController: UIViewController?
    open var delegate: UPennStartupCoordinatorDelegate?
    
    public init(navController: UINavigationController, delegate: UPennStartupCoordinatorDelegate) {
        self.navigationController = navController
        // IOS 15 TableView Header-padding Bug
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        self.delegate = delegate
    }
    
    open func start() {
        // Do Stuff
        
        // Startup Callback
        self.delegate?.configureStartup()
    }
}
