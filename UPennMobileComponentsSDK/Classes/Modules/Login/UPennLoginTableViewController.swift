//
//  UPennLoginTableViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

/// Interface for an object to properly handle login view-model functionality

public protocol UPennLoginViewModelled {
    func numberSectionRows(_ section: Int) -> Int
    func cellForRowAt(_ indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell
}

open class UPennLoginTableViewController : UPennStoryboardViewController, UPennLoginViewControllable {
    
    enum Section : Int {
        case Username
        case Password
        case Login
        
        static var Count : Int {
            return Section.Login.rawValue+1
        }
    }
    
    @IBOutlet public weak var loginTableView: UITableView!
    
    public var viewModel : UPennLoginViewModelled!
    open var presenter : UPennLoginPlusBiometricsInterface!
    open var coordinator : UPennLoginCoordinatorDelegate!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        self.loginTableView.delegate = self
        self.loginTableView.dataSource = self
        self.loginTableView.separatorStyle = .none
    }
    
    open func forgotPassword() {
        print("Pressed Forgot Password")
    }
    
}

extension UPennLoginTableViewController : UITableViewDelegate {
    
}

extension UPennLoginTableViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.viewModel.numberSectionRows(section)
        return Section.Count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        self.viewModel.cellForRowAt(indexPath, for: tableView)
        
        guard let section = Section.init(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch section {
        case .Username:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredUsernameTextFieldCell.Identifier) as! UPennCenteredUsernameTextFieldCell
            cell.configure(delegate: self)
            return cell
        case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredPasswordTextFieldCell.Identifier) as! UPennCenteredPasswordTextFieldCell
            cell.configure(delegate: self)
            return cell
        case .Login:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
            cell.configure(title: "Login".localize, delegate: self)
            return cell
        }
    }
    
    
    
}

extension UPennLoginTableViewController : UITextFieldDelegate {
    
}

extension UPennLoginTableViewController : UPennCenteredButtonDelegate {
    public func pressedButton(_ button: UIButton) {
        UPennActivityPresenter.Show(message: "Logging in.....")
        print("Login Button Pressed!")
        // Login User either directly or via delegate
        self.presenter.makeLoginRequest(username: "", password: "")
    }
}

extension UPennLoginTableViewController : UPennLoginPresenterDelegate {
    public func registerForTouchIDAuthentication() {
        //
    }
    
    public func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        //
    }
    
    public func biometricsDidError(with message: String?) {
        //
    }
    
    public func didSuccessfullyLoginUser() {
        //
    }
    
    public func didReturnAutoFillCredentials(username: String, password: String) {
        //
    }
    
    public func didFailToLoginUser(errorStr: String) {
        //
    }
    
    
    
    
}
