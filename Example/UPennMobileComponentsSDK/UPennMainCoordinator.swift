//
//  UPennMainCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/24/21.
//

import Foundation
import UIKit
import UPennMobileComponentsSDK

class UPennMainCoordinator : UPennCoordinator {
    
    var childCoordinators = [UPennCoordinator]()
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
        // TODO: Add Child Coordinators for MainApp and LoginUX
    }
    
    func start() {
        // Start LoginCoordinator?
        let loginCoordinator = UPennLoginCoordinator(navController: self.navigationController, coordinatorDelegate: self)
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension UPennMainCoordinator : UPennLoginCoordinatorDelegate {
    func didSuccessfullyLoginUser() {
        // TODO: Swap from LoginVC to MainVC
    }
    
    
    
    
}
