//
//  UPennSettingsViewController.swift
//  UPennMobileComponentsSDK-UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/30/21.
//

import Foundation
import UIKit

public class UPennSettingsViewController : UPennStoryboardViewController {
    
    private enum Sections : Int,UPennCountable {
        case Settings
        
        static var Count : Int {
            return Settings.rawValue+1
        }
        
        enum Rows : Int, UPennCountable {
            case Timeout
            case Biometrics
            case Withdraw
            case Logout
            
            static var Count : Int {
                return Logout.rawValue+1
            }
        }
    }
    
    private enum SectionTitles : String {
        case Settings = "Settings"
    }
    
    private enum Identifiers : String {
        case Timeout = "TimeoutCell"
        case Biometrics = "BiometricsCell"
        case Withdraw = "WithdrawCell"
        case Logout = "LogoutCell"
    }
    
    public var settingsCoordinator : UPennLogoutBiometricsDelegate?
    
    var biometricsService = UPennBiometricsAuthService()
    
    open var viewModel: UPennSettingsViewModelled!
    
    @IBOutlet weak var settingsTableView : UITableView!
    
    public override func viewDidLoad() {
        self.setup()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.settingsTableView.reloadData()
    }
    
    func setup() {
        super.navBarSetup()
        self.navigationItem.title = "Account"
//        self.navigationController?.navigationBar.isHidden = true
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
    }
    
    // Logs out and resets Onboarding for the withdraw aler
    func logoutAndResetDefaults(_ action: UIAlertAction) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "OnboardingCompletedKey")
        
        self.settingsCoordinator?.logout()
    }
}

extension UPennSettingsViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowsInSection(section)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections(tableView)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.viewModel.getCellAtIndexPath(indexPath, for: tableView)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForIndexPath(indexPath, for: tableView)
    }
    
//    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
}
 
extension UPennSettingsViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return self.viewModel.tableView(tableView, selectedIndexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForHeaderInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeaderInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.heightForFooterInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(section, for: tableView)
    }
}

extension UPennSettingsViewController : UPennBiometricsToggleDelegate {
    func toggledBiometrics(_ enabled: Bool) {
        self.settingsCoordinator?.toggleShouldAutoFill(enabled)
    }
}

extension UPennSettingsViewController : UPennSettingsInterface {
    public func presentWithDraw() {
        self.present(self.withdrawAlert, animated: true, completion: nil)
    }
    
    public func logout() {
        self.settingsCoordinator?.logout()
    }
    
    public func toggleShouldAutoFill(_ enabled: Bool) {
        self.settingsCoordinator?.toggleShouldAutoFill(enabled)
    }
    
    
    
    
}

extension UPennSettingsViewController {
    var withdrawAlert : UIAlertController {
        let alert = UIAlertController(
            title: "Withdrawing from Study?".localize,
            message: "Are you sure you want to withdraw from the study? To withdraw, please contact 267-760-7850.".localize,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .default, handler: nil)
        
//        let config = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
//        if config == "Debug-TEST" { // Change to "Debug-PROD" to test with Xcode. Withdraw button will only show in "Debug-TEST"
            let withdrawAction = UIAlertAction(title: "Reset Onboarding", style: .destructive, handler: logoutAndResetDefaults)
            alert.addAction(withdrawAction)
            
//        }
        
        alert.addAction(cancelAction)
        return alert
    }
}


