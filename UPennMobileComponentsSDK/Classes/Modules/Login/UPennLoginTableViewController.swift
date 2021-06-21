//
//  UPennLoginTableViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

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
    
    open var presenter : UPennLoginPlusBiometricsInterface!
    open var coordinator : UPennLoginCoordinatorDelegate!
    open var username: String = ""
    open var password: String = ""
    open var textFieldManager = UPennValidationService()
    
    fileprivate lazy var touchIDAlertController : UIAlertController = {
        let fieldContent = UPennTouchIDFieldContent(title: self.presenter.touchIDOptInTitle, message: self.presenter.touchIDOptInMessage, declined: self.presenter.touchIDDeclined, confirmed: self.presenter.touchIDConfirmed)
        let alertController = UPennAlertsPresenter.TouchIDAlertController(content: fieldContent) { (selection) in
            switch selection {
            case .Cancel:
                // Force biometrics off, and complete login flow to close-out LoginVC
                self.presenter.toggleBiometrics(false)
                self.coordinator.didSuccessfullyLoginUser()
            case .Use:
                // Turn on Biometrics Settings & complete Touch ID registration to ensure no repeat launches of Touch ID alert
                self.turnOnBiometricAuthSettings()
                self.presenter.completeTouchIDRegistration()
            }
        }
        return alertController
    }()
    
    fileprivate lazy var rememberMeAlertController : UIAlertController = {
        let alertController = UPennAlertsPresenter.RememberMeAlertController(biometricsOptOutMessage: self.presenter.biometricOptOutMessage) {
            self.presenter.toggleBiometrics(false)
//            self.toggleRememberMe()
//            self.updateView()
        }
        return alertController
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        self.loginTableView.delegate = self
        self.loginTableView.dataSource = self
        self.loginTableView.separatorStyle = .none
    }
    
    open func viewDidDisappear() {

        
    }
    
    open func forgotPassword() {
        print("Pressed Forgot Password")
    }
    
    @objc open func textFieldDidChange(_ sender: Any) {
        guard
            let textField = sender as? UITextField,
            let text = textField.text,
            let section = Section(rawValue: textField.tag) else { return }
        
        switch section {
        case .Username: self.username = text
        case .Password: password = text
        case .Login: return
        }
        self.loginTableView.reloadRows(at: [IndexPath(row: Section.Login.rawValue, section: 0)], with: .none)
    }
    
    open func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics settings
         * 2. Toggle 'Remember Me' On
         */
        self.presenter.turnOnBiometricAuthSettings()
//        self.toggleRememberMe(true)
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
            cell.configure(delegate: self, textFieldTag: section.rawValue)
            self.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredPasswordTextFieldCell.Identifier) as! UPennCenteredPasswordTextFieldCell
            cell.configure(delegate: self, textFieldTag: section.rawValue)
            self.textFieldManager.addTextFieldAndTag(&cell.textInputView.textInput, section.rawValue)
            return cell
        case .Login:
            let cell = tableView.dequeueReusableCell(withIdentifier: UPennCenteredButtonCell.Identifier) as! UPennCenteredButtonCell
            cell.configure(title: "Login".localize, delegate: self, enabled: self.textFieldManager.allFieldsAreValid)
            return cell
        }
    }
}

extension UPennLoginTableViewController : UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldManager.advanceTextfields(textField, parentView: self.view) {
            self.login()
        }
        return true
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

extension UPennLoginTableViewController : UPennCenteredButtonDelegate {
    public func pressedButton(_ button: UIButton) {
        UPennActivityPresenter.Show(message: "Logging in.....")
        // Login User either directly or via delegate
        self.login()
    }
}

extension UPennLoginTableViewController : UPennLoginPresenterDelegate {
    public func registerForTouchIDAuthentication() {
        UPennActivityPresenter.Dismiss()
       self.present(self.touchIDAlertController, animated: true, completion: nil)
    }
    
    public func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
    }
    
    public func biometricsDidError(with message: String?) {
        UPennActivityPresenter.ShowError(message: message ?? "")
    }
    
    public func didSuccessfullyLoginUser() {
        UPennActivityPresenter.Dismiss()
        self.coordinator.didSuccessfullyLoginUser()
        self.resetView()
    }
    
    public func didReturnAutoFillCredentials(username: String, password: String) {
        //
    }
    
    public func didFailToLoginUser(errorStr: String) {
        UPennActivityPresenter.ShowError(message: errorStr)
    }
    
    public func loginIsDismissed() {
        self.resetView()
    }
}

private extension UPennLoginTableViewController {
    
    func login() {
        self.presenter.makeLoginRequest(username: self.username, password: self.password)
    }
    
    func resetView() {
        self.textFieldManager.resetTextFields()
        self.loginTableView.reloadData()
    }
}
