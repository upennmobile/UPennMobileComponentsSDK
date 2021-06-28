//
//  UPennLoginTableViewController.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/18/21.
//

import Foundation
import UIKit

open class UPennLoginTableViewController : UPennStoryboardViewController, UPennLoginViewControllable {
    
    @IBOutlet public weak var loginTableView: UITableView!
    open var viewModel: UPennLoginViewModelled!
    open var presenter : UPennLoginPlusBiometricsInterface!
    open var coordinator : UPennLoginCoordinatorDelegate!
    open var username: String = ""
    open var password: String = ""
    open var textFieldManager = UPennValidationService()
    
    open var shouldAutoFill: Bool {
        return self.presenter.shouldAutoFill
    }
    
    open var biometricsEnabled: Bool {
        return self.presenter.biometricsEnabled
    }
    
    open var biometricsImage: UIImage {
        return self.presenter.biometricsImage
    }
    
    open func toggleShouldAutoFill(_ autoFill: Bool) {
        self.presenter.toggleShouldAutoFill(autoFill)
    }
    
    open func attemptBiometricsAuthentication() {
        self.presenter.attemptBiometricsAuthentication()
    }
    
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
    
    fileprivate var rememberMeAlertController : UIAlertController {
        let alertController = UPennAlertsPresenter.RememberMeAlertController(biometricsOptOutMessage: self.presenter.biometricOptOutMessage)
        {
            // Toggle off biometrics in cache
            self.presenter.toggleBiometrics(false)
        } cancelCallback: {
            // Must reload 'Remember Me' section to toggle button back 'on', because it's already toggled 'off' in the button View; cache needs no updating
            self.loginTableView.reloadRows(at: self.viewModel.rememberMeUpdateSections(), with: .none)
        }
        return alertController
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        self.loginTableView.delegate = self
        self.loginTableView.dataSource = self
        self.loginTableView.separatorStyle = .none
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.authenticationAutoFillCheck()
        self.attemptBiometricsAuthentication()
    }
    
    open func forgotPassword() {
        print("Pressed Forgot Password")
    }
    
    @objc open func textFieldDidChange(_ sender: Any) {
        
        guard let textField = sender as? UITextField else { return }
        
        self.viewModel.textChangedUpdateView(textField: textField) { username, password, indexPaths in
            if let u = username {
                self.username = u
            }
            if let p = password {
                self.password = p
            }
            self.loginTableView.reloadRows(at: indexPaths, with: .none)
        }
    }
    
    open func turnOnBiometricAuthSettings() {
        self.presenter.turnOnBiometricAuthSettings()
    }
    
    open func presentRememberMeAlert() {
        self.present(self.rememberMeAlertController, animated: false, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate

extension UPennLoginTableViewController : UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension UPennLoginTableViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowsInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.viewModel.getCellAtIndexPath(indexPath, for: tableView)
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

// MARK: - UPennCenteredButtonDelegate

extension UPennLoginTableViewController : UPennCenteredButtonDelegate {
    public func pressedCenterButton(_ button: UIButton) {
        UPennActivityPresenter.Show(message: "Logging in.....")
        // Login User
        self.login()
    }
}

// MARK: - UPennLoginPresenterDelegate

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
        self.username = username
        self.loginTableView.reloadRows(at: self.viewModel.autofillUpdateSections(), with: .none)
    }
    
    public func didFailToLoginUser(errorStr: String) {
        UPennActivityPresenter.ShowError(message: errorStr)
    }
    
    public func loginIsDismissed() {
        self.resetView()
    }
}

// MARK: - Private

private extension UPennLoginTableViewController {
    
    func resetView() {
        self.textFieldManager.resetTextFields()
        self.username = ""
        self.password = ""
        self.loginTableView.reloadData()
    }
}
