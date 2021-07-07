//
//  UPennSettingsViewModel.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 7/6/21.
//

import Foundation
import UIKit

open class UPennSettingsViewModel : UPennSettingsViewModelled {
    
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
    
    open var controller: UPennSettingsInterface
    open var biometricsService: UPennBiometricsAuthenticationInterface
    
    public init(controller: UPennSettingsInterface, biometricsService: UPennBiometricsAuthenticationInterface?=nil) {
        self.controller = controller
        if let bioMet = biometricsService {
            self.biometricsService = bioMet
        } else {
            self.biometricsService = UPennBiometricsAuthService()
        }
    }
    
    public func rowsInSection(_ section: Int) -> Int {
        guard let _section = Sections(rawValue: section) else { return 0 }
        
        switch _section {
        case .Settings:
            return Sections.Rows.Count
        }
    }
    
    public func numberOfSections(_ tableView:UITableView) -> Int {
        return Sections.Count
    }
    
    public func getCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell {
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
    
    open func tableView(_ tableView: UITableView, selectedIndexPath: IndexPath) {
        guard let section = Sections(rawValue: selectedIndexPath.section), let row = Sections.Rows(rawValue: selectedIndexPath.row) else { return }
        // Logout User if Logout Cell pressed
        switch section {
        case .Settings:
            switch row {
            case .Logout: self.controller.logout()
            case .Withdraw: self.controller.presentWithDraw()
            default: return
            }
        }
    }
    
    
    // MARK: UPennTableViewSectionsHeaderAndFooterDelegate
    
    open func titleForHeaderInSection(_ section: Int) -> String {
        return SectionTitles.Settings.rawValue
    }
    
    open func heightForHeaderInSection(_ section: Int) -> CGFloat {
        return 50
    }
    
    open func heightForFooterInSection(_ section: Int) -> CGFloat {
        return 40
    }
    
    open func viewForFooterInSection(_ section: Int, for tableView: UITableView) -> UIView {
        
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

extension UPennSettingsViewModel : UPennBiometricsToggleDelegate {
    open func toggledBiometrics(_ enabled: Bool) {
        self.biometricsService.toggleBiometrics(enabled)
        // If biometrics is enabled, toggle 'Remember Me' on in LoginVC
        if enabled {
            self.controller.toggleShouldAutoFill(enabled)
        }
    }
}
