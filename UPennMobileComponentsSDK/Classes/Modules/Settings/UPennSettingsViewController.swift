//
//  UPennSettingsViewController.swift
//  UPennMobileComponentsSDK-UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 3/30/21.
//

import Foundation
import UIKit

public class UPennSettingsViewController : UPennStoryboardViewController {
    
    private enum Sections : Int {
        case Settings
        
        static var count : Int {
            return Settings.rawValue+1
        }
        
        enum Rows : Int {
            case Timeout
            case Biometrics
            case Withdraw
            case Logout
            
            static var count : Int {
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
        guard let _section = Sections(rawValue: section) else { return 0 }
        
        switch _section {
        case .Settings:
            return Sections.Rows.count
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Sections(rawValue: indexPath.section), let row = Sections.Rows(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch section {
        case .Settings:
            switch row {
            case .Timeout:
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Timeout.rawValue) as! UPennAutoLogoutCell
                return cell
            case .Biometrics:
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Biometrics.rawValue) as! UPennBiometricsEnableCell
                cell.configure(with: self, biometricsService: self.biometricsService)
                return cell
            case .Withdraw:
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Withdraw.rawValue) as! UPennWithdrawCell
                cell.configure()
                return cell
            case .Logout:
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.Logout.rawValue) as! UPennLogoutCell
                cell.configure()
                return cell
            }
        }
    }
    
}
 
extension UPennSettingsViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section), let row = Sections.Rows(rawValue: indexPath.row) else { return }
        // Logout User if Logout Cell pressed
        switch section {
        case .Settings:
            switch row {
            case .Logout: self.settingsCoordinator?.logout()
            case .Withdraw: self.present(self.withdrawAlert, animated: true, completion: nil)
            default: return
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitles.Settings.rawValue
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Create View
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UPennScreenGlobals.Width, height: 30))
        view.backgroundColor = UIColor.upennRlyLightGray
        // Create Label
        let versionStr = UPennApplicationSettings.CurrentAppVersion
        
        let titleLabel = UPennLabel(frame: CGRect(x: UPennScreenGlobals.Padding, y: 20, width: UPennScreenGlobals.Width - (UPennScreenGlobals.Padding*2), height: 20))
        titleLabel.textColor = UIColor.upennBlack
        titleLabel.textAlignment = .right
        titleLabel.setFontHeight(size: 10)
        let appname = UPennApplicationSettings.AppDisplayName
        let versionText = "\(appname) Version \(versionStr)"
        titleLabel.text = versionText.localize
        view.addSubview(titleLabel)
        return view
    }
}

extension UPennSettingsViewController : UPennBiometricsToggleDelegate {
    func toggledBiometrics(_ enabled: Bool) {
        self.biometricsService.toggleBiometrics(enabled)
        // If biometrics is enabled, toggle 'Remember Me' on in LoginVC
        if enabled {
            self.settingsCoordinator?.toggleShouldAutoFill(enabled)
        }
    }
}

extension UPennSettingsViewController {
    var withdrawAlert : UIAlertController {
        let alert = UIAlertController(
            title: "Withdrawing from Study?".localize,
            message: "Are you sure you want to withdraw from the study? To withdraw, please contact 267-760-7850.".localize,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .default, handler: nil)
        
        let config = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
        if config == "Debug-TEST" { // Change to "Debug-PROD" to test with Xcode. Withdraw button will only show in "Debug-TEST"
            let withdrawAction = UIAlertAction(title: "Reset Onboarding", style: .destructive, handler: logoutAndResetDefaults)
            alert.addAction(withdrawAction)
            
        }
        
        alert.addAction(cancelAction)
        return alert
    }
}


