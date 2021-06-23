//
//  UPennLoginViewModel.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

public protocol UPennLoginViewModelled {
    func getCellAtIndexPath(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell
    func textChangedUpdateView(textField: UITextField, completion: @escaping (_ username: String?, _ password: String?, _ indexPaths: Array<IndexPath>)->Void)
    func rowsInSection(_ section: Int) -> Int
    
    func autofillUpdateSections() -> Array<IndexPath>
}

public protocol UPennLoginViewModelDelegate {
    func login()
}

open class UPennLoginViewModel : NSObject, UPennLoginViewModelled {
        
    enum LoginSection : Int {
        case BannerImage
        case Username
        case Password
        case Login
        
        static var Count : Int {
            return LoginSection.Login.rawValue+1
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
//
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
        case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredPasswordTextFieldCell.Identifier) as! UPennCenteredPasswordTextFieldCell
            cell.configure(delegate: self.controller, textFieldContent: nil, textFieldTag: section.rawValue)
            self.controller.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .Login:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
            cell.configure(title: "Login".localize, delegate: self, enabled: self.controller.textFieldManager.allFieldsAreValid)
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
        
        completion(text,text,[IndexPath(row:LoginSection.Login.rawValue, section: 0)])

       switch section {
       case .Username: self.controller.username = text
       case .Password: self.controller.password = text
       case .Login,.BannerImage: return
       }
    }
    
    open func rowsInSection(_ section: Int) -> Int {
        return LoginSection.Count
    }
    
    open func autofillUpdateSections() -> Array<IndexPath> {
        return [IndexPath(row:LoginSection.Username.rawValue, section: 0)]
    }
}

extension UPennLoginViewModel : UPennCenteredButtonDelegate {
    public func pressedButton(_ button: UIButton) {
        // Login User either directly or via delegate
        self.controller.login()
    }
}
