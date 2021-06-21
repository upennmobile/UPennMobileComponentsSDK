//
//  UPennLoginViewModel.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

open class UPennLoginViewModel : NSObject {
    
    enum Section : Int {
        case Username
        case Password
        case Login
        
        static var Count : Int {
            return Section.Login.rawValue+1
        }
    }
    
    open var presenter: UPennLoginPresentable
    
    public init(presenter: UPennLoginPresentable) {
        self.presenter = presenter
    }
    
    public func numberSectionRows(_ section: Int) -> Int {
        return Section.Count
    }
    
//    public func cellForRowAt(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell {
//        
//        guard let section = Section.init(rawValue: indexPath.row) else { return UITableViewCell() }
//        
//        switch section {
//        case .Username:
//            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredUsernameTextFieldCell.Identifier) as! UPennCenteredUsernameTextFieldCell
//            cell.configure(delegate: self)
//            return cell
//        case .Password:
//            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredPasswordTextFieldCell.Identifier) as! UPennCenteredPasswordTextFieldCell
//            cell.configure(delegate: self)
//            return cell
//        case .Login:
//            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
//            cell.configure(title: "Login".localize, delegate: self)
//            return cell
//        }
//    }
}

extension UPennLoginViewModel : UITextFieldDelegate {
    
}

extension UPennLoginViewModel : UPennCenteredButtonDelegate {
    public func pressedButton(_ button: UIButton) {
        print("Login Button Pressed!")
        // Login User either directly or via delegate
        self.presenter.makeLoginRequest(username: "", password: "")
    }
}
