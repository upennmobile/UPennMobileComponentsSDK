//
//  UPennMasterCoordinatable.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/1/21.
//

import Foundation
import UIKit

/// Interface for a Master Coordinator which can respond to login/logout events and manage the transitions between Login and Main UI/UX
public protocol UPennMasterCoordinatable : UPennCoordinator, UPennLoginCoordinatorDelegate, UPennLogoutBiometricsDelegate {
    
    var loginCoordinator : UPennLoginCoordinated? {get set}
    var mainCoordinator : UPennMainCoordinatable? {get set}
    func dismissAndPresentLogout()
    func showMainViewController()
    func showLoginVsMainViewController()
    func swapLoginFromMainViewController()
    func showLogin()
    func showLogoutAlert()
    
}
