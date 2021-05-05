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
    func makeTabBarControllers()
    func configureTabBarItems()
}

open class UPennMainCoordinator : NSObject, UPennMainCoordinatable {
    public var childCoordinators: [UPennCoordinator] = [UPennCoordinator]()
    
    public var navigationController: UINavigationController
    
    public var childViewController: UIViewController?
    
    var tabController : UITabBarController?
    public var logoutBiometricsDelegate : UPennLogoutBiometricsDelegate?
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
//        self.visibleViewController = self.navigationController.visibleViewController!
//        self.tabController = self.makeViewController(identifier: "TabBarVC") as? UITabBarController
//        self.tabController = UPennTabBarController.Instantiate(.SDK)
        self.tabController = UPennTabBarController.Instantiate(.SDK)
        self.childViewController = tabController
        super.init()
        tabController?.delegate = self
    }
    
    public func start() {
        // TODO: Configure TabViewController?
        
        self.makeTabBarControllers()
    }
    
    // MARK: - VC Factory Methods
    
    func makeViewController(identifier: String) -> UIViewController? {
//        let navVC = self.appDelegate?.storyboard.instantiateViewController(withIdentifier: identifier)
//        return navVC
        return UIViewController()
    }
    
    open func makeTabBarControllers() {
        // AccountsVC
        let settingsCoord = UPennSettingsCoordinator(navController: self.navigationController, settingsCoordinatorDelegate: self)
//            self.accountsViewController = self.makeViewController(identifier: "SettingsNav") as? UPennSettingsViewController
        settingsCoord.start()
            self.tabController?.viewControllers = [
/*                UINavigationController(rootViewController: self.nfcViewController!) --- Remove for Pippenn-251 ---
                vc,*/
//                UINavigationController(rootViewController: self.careViewController!),
//                UINavigationController(rootViewController: self.careTeamViewController!),
                UINavigationController(rootViewController: settingsCoord.childViewController!)
            ]
            self.tabController?.selectedIndex = 0
            self.configureTabBarItems()
//        }
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

extension UPennMainCoordinator : UITabBarControllerDelegate { }

//extension UPennMainCoordinator : UPennLogoutBiometricsDelegate {
//}
