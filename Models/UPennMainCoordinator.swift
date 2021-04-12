//
//  UPennMainCoordinator.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/1/21.
//

import Foundation
import UIKit

public class UPennMainCoordinator : NSObject, UPennCoordinator {
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
//        self.loginNavController = self.makeViewController(identifier: "LoginNav")
    }
    
    // MARK: - VC Factory Methods
    
    func makeViewController(identifier: String) -> UIViewController? {
//        let navVC = self.appDelegate?.storyboard.instantiateViewController(withIdentifier: identifier)
//        return navVC
        return UIViewController()
    }
    
    func makeTabBarControllers() {
//        if
//            let manager = self.storeManager,
//            let careStore = self.careStore
//        {
            // NFCVC
//            self.nfcViewController = PPNFCScanViewController(storeManager: manager, careStore: careStore)
//            // CarePlanVC
//            self.careViewController = PPCarePlanViewController(storeManager: manager, careStore: careStore)
//            // ContactsVC
//            self.careTeamViewController = PPCareTeamViewController(storeManager: manager, careStore: careStore)
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
    
    func configureTabBarItems() {
   
        // Set selected image & text tintColor
        self.tabController?.tabBar.tintColor = UIColor.black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.upennDeepBlue], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.upennRlyLightGray], for: .normal)
        
        // Scan
        /*let myTabBarItem1 = (self.tabController.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage.NFCScanImage.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage.NFCScanImage.withTintColor(.upennDeepBlue, renderingMode: .alwaysOriginal)
        myTabBarItem1.title = "Scan" --- Remove for PipPenn-251 --- */
        
        // Care Plan
//        let myTabBarItem2 = (self.tabController.tabBar.items?[0])! as UITabBarItem
//        myTabBarItem2.image = UIImage.CarePlanUnSelected.withRenderingMode(.alwaysOriginal)
//        myTabBarItem2.selectedImage = UIImage.CarePlanSelected.withRenderingMode(.alwaysOriginal)
//        myTabBarItem2.title = "Care Plan"
//
//        // Contacts
//        let myTabBarItem3 = (self.tabController.tabBar.items?[1])! as UITabBarItem
//        myTabBarItem3.image = UIImage.ContactsUnSelected.withRenderingMode(.alwaysOriginal)
//        myTabBarItem3.selectedImage = UIImage.ContactsSelected.withRenderingMode(.alwaysOriginal)
//        myTabBarItem3.title = "Contacts"
        
        // Accounts
        let myTabBarItem4 = (self.tabController?.tabBar.items?[0])! as UITabBarItem
        myTabBarItem4.image = UPennImageAssets.AccountUnSelected.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.selectedImage = UPennImageAssets.AccountSelected.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.title = "Accounts"
    }
}

extension UPennMainCoordinator : UITabBarControllerDelegate { }

extension UPennMainCoordinator : UPennLogoutBiometricsDelegate {
    public func logout() {
        // TODO: Fire delegates into MasterCoordinator to handle?
        self.logoutBiometricsDelegate?.logout()
    }
    
    public func toggleShouldAutoFill(_ enabled: Bool) {
        // TODO: Fire delegates into MasterCoordinator to handle?
        self.logoutBiometricsDelegate?.toggleShouldAutoFill(enabled)
    }
    
    
    
}
