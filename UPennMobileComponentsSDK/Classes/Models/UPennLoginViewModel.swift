//
//  UPennLoginViewModel.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

/**
 Concrete class emplementing 'UPennLoginViewModelled' for custom configuration of UPennLoginTableVC
 
 - Subclass this with custom implementation of LoginSection, getCellAtIndexPath & textChangedUpdateView for alternate LoginVC layouts
 */
open class UPennLoginViewModel : NSObject, UPennLoginViewModelled {
      
    /// Enum representing separate pieces of Login UI content. Must custom override if subclassing UPennLoginViewModel.
    public enum LoginSection : Int {
        case BannerImage
        case AppTitle
        case Username
        case Password
        case RememberMe
        case Login
        case ForgotPassword
        case Biometrics
        
        static var Count : Int {
            return LoginSection.Biometrics.rawValue+1
        }
    }
    
    open var controller: UPennLoginViewControllable & UPennLoginViewModelDelegate & UITextFieldDelegate
    
    public init(controller: UPennLoginViewControllable & UPennLoginViewModelDelegate & UITextFieldDelegate) {
        self.controller = controller
    }
    
    open func numberSectionRows(_ section: Int) -> Int {
        return LoginSection.Count
    }
    
    open func getCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell {

        guard let section = LoginSection.init(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch section {
        
        case .BannerImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennImageViewCell.Identifier) as! UPennImageViewCell
            cell.configure(image: UPennImageAssets.UPennBannerTransparent)
            return cell
        case .AppTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredLabelCell.Identifier) as! UPennCenteredLabelCell
            cell.configure(text: UPennApplicationSettings.AppDisplayName.localize, styles: BannerLabelStyles.Style as! UPennLabelStyles)
            return cell
        case .Username:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredUsernameTextFieldCell.Identifier) as! UPennCenteredUsernameTextFieldCell
            cell.configure(delegate: self.controller, textFieldContent: self.controller.username, textFieldTag: section.rawValue)
            self.controller.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredPasswordTextFieldCell.Identifier) as! UPennCenteredPasswordTextFieldCell
            cell.configure(delegate: self.controller, textFieldContent: nil, textFieldTag: section.rawValue)
            self.controller.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .RememberMe:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennLeftImageButtonCell.Identifier) as! UPennLeftImageButtonCell
            let edgeInsets = UIEdgeInsets(top: 7.5, left: -65, bottom: 17.5, right: 0)
            let imageTitlePadding: CGFloat = -55.0
            let styles = UPennButtonStyles(
                selectedImage: UPennImageAssets.CheckedCheckBox, deselectedImage: UPennImageAssets.UnCheckedCheckBox, isSelected: controller.shouldAutoFill,
                titleFont: UIFont.helvetica(size: 17.0),
                titleColor: .upennDarkBlue,
                width: 120,
                height: 50,
                backgroundColor: .clear,
                contentPadding: edgeInsets,
                imageTitlePadding: imageTitlePadding)
            cell.configure(title: "Remember Me", styles: styles, delegate: self)
            return cell
        case .Login:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
            cell.configure(title: "Login".localize, delegate: self, enabled: self.controller.textFieldManager.allFieldsAreValid)
            return cell
        case .ForgotPassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennRightButtonCell.Identifier) as! UPennRightButtonCell
            let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let styles = UPennButtonStyles(
                titleFont: UIFont.helvetica(size: 17.0),
                titleColor: .upennDarkBlue,
                width: 120,
                height: 50,
                backgroundColor: .clear,
                contentPadding: edgeInsets)
            cell.configure(
                title: "Forgot Password",
                styles: styles,
                delegate: self)
            return cell
        case .Biometrics:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredIconButtonCell.Identifier) as! UPennCenteredIconButtonCell
            cell.configure(image: controller.biometricsImage, delegate: self, styles: UPennButtonStyles(
                    deselectedImage: controller.biometricsImage,
                    isHidden: !controller.biometricsEnabled,
                    height: 50,
                    backgroundColor: .clear,
                    contentPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                        imageTitlePadding: 0.0))
            return cell
        }
    }
    
    open func textChangedUpdateView(textField: UITextField, completion: @escaping (
            _ username: String?,
            _ password: String?,
            _ indexPaths: Array<IndexPath>) -> Void) {
        guard
           let text = textField.text,
           let section = LoginSection(rawValue: textField.tag) else { return }
        
        let idxPaths = [IndexPath(row:LoginSection.Login.rawValue, section: 0)]

       switch section {
       case .Username:
        completion(text,nil,idxPaths); break
       case .Password:
        completion(nil,text,idxPaths); break
       default: return
       }
    }
    
    open func rowsInSection(_ section: Int) -> Int {
        return LoginSection.Count
    }
    
    open func autofillUpdateSections() -> Array<IndexPath> {
        return [IndexPath(row:LoginSection.Username.rawValue, section: 0)]
    }
    
    open func toggleRememberMe(_ button: UIButton, _ enabled: Bool = false) {
        self.controller.toggleShouldAutoFill(button.isSelected)
    }
    
    open func rememberMeUpdateSections() -> Array<IndexPath> {
        return [IndexPath(row: LoginSection.RememberMe.rawValue, section: 0)]
    }
}

extension UPennLoginViewModel : UPennCenteredButtonDelegate {
    public func pressedCenterButton(_ button: UIButton) {
        // Login User either directly or via delegate
        self.controller.login()
    }
}

extension UPennLoginViewModel : UPennLeftImageButtonDelegate {
    public func pressedLeftImageButton(_ button: UIButton) {
        if !button.isSelected && controller.biometricsEnabled {
            self.controller.presentRememberMeAlert()
            return
        }
        self.toggleRememberMe(button)
    }
}

extension UPennLoginViewModel : UPennRightButtonDelegate {
    
    public func pressedRightButton(_ button: UIButton) {
        self.controller.forgotPassword()
    }
}

extension UPennLoginViewModel : UPennCenteredIconButtonDelegate {
    
    public func pressedIconButton(_ button: UIButton) {
        controller.attemptBiometricsAuthentication()
    }
}
