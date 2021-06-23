//
//  ViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by rabdulsal on 05/07/2021.
//  Copyright (c) 2021 rabdulsal. All rights reserved.
//

import UIKit
import UPennMobileComponentsSDK

class TestUPennLoginViewModel : UPennLoginViewModel {
    
    enum LoginSection : Int {
        case BannerImage, Username, Login
    }
    
    override func textChangedUpdateView(textField: UITextField, completion: @escaping (
            _ username: String?,
            _ password: String?,
            _ indexPaths: Array<IndexPath>) -> Void) {
        guard
           let text = textField.text,
           let section = LoginSection(rawValue: textField.tag) else { return }
        
        completion(text,text,[IndexPath(row:LoginSection.Login.rawValue, section: 0)])

       switch section {
       case .Username: self.controller.username = text
       case .Login,.BannerImage: return
       }
    }
    
    override func getCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell {
        
        guard let section = LoginSection.init(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch section {
        
        case .BannerImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennImageViewCell.Identifier) as! UPennImageViewCell
            cell.configure(image: UPennImageAssets.UPennBannerTransparent)
            return cell
        case .Username:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredUsernameTextFieldCell.Identifier) as! UPennCenteredUsernameTextFieldCell
            cell.configure(delegate: self.controller, textFieldContent: self.controller.username, textFieldTag: section.rawValue)
            self.controller.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .Login:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
            cell.configure(title: "Login".localize, delegate: self, enabled: self.controller.textFieldManager.allFieldsAreValid)
            return cell
        }
    }
    
}

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
        let childVC = UPennLoginTableViewController.Instantiate(.SDK)
        childVC.viewModel = TestUPennLoginViewModel(controller: childVC)
        // Make Login presenter
        let presenter = UPennLoginPresenter(presenterDelegate: childVC)
        // Make LoginCoordinator
        let loginCoordinator = UPennLoginCoordinator(navController: self.navigationController, childViewController: childVC, presenter: presenter)
        // Set LoginVC presenter
        childVC.presenter = presenter
        // Set LoginVC coordinator
        childVC.coordinator = loginCoordinator
        // Set MasterCoordinator
        self.masterCoordinator = UPennMasterCoordinator(navController: self.navigationController, childCoordinators: [loginCoordinator,mainCoordinator])
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

