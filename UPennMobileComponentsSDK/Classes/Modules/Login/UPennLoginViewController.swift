//
//  UPennLoginViewController.swift
//  PipPenn Patient
//
//  Created by Rashad Abdul-Salam on 3/21/20.
//  Copyright © 2020 University of Pennsylvania. All rights reserved.
//

import Foundation
import UIKit
//import SVProgressHUD
//import UPennMobileComponentsSDK

open class UPennLoginViewController: UPennStoryboardViewController, UPennLoginViewControllable {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: PrimaryCTAButton!
    @IBOutlet weak var autoFillButton: PrimaryCTAButtonText!
    @IBOutlet weak var titleLabel: BannerLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rememberMeLabel: ContactDepartmentLabel!
    @IBOutlet weak var forgotPasswordLabel: UIButton!
    @IBOutlet weak var upennBannerLogo: UIImageView!
    @IBOutlet weak var biometricsButtonView : UPennIconButtonView!
    
    fileprivate var validationService: UPennValidationService!
    fileprivate var keyboardService: UPennKeyboardService!
    open var presenter : UPennLoginPlusBiometricsInterface!
    open var coordinator : UPennLoginCoordinatorDelegate!
    fileprivate var isFirstLogin : Bool {
        return UPennAuthenticationService.IsFirstLogin
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
    
    fileprivate lazy var rememberMeAlertController : UIAlertController = {
        let alertController = UPennAlertsPresenter.RememberMeAlertController(biometricsOptOutMessage: self.presenter.biometricOptOutMessage) {
            self.presenter.toggleBiometrics(false)
            self.toggleRememberMe()
            self.updateView()
        }
        return alertController
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppear()
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewDidDisappear()
    }
    
    open func forgotPassword() {
        print("Pressed 'Forgot Password'!")
    }
    
    func setup() {
        self.title = "Sign In"
        self.titleLabel.text = UPennApplicationSettings.AppDisplayName.localize
        
        // Set up textFields
        self.emailField.delegate = self
        self.emailField.placeholder = "username".localize
        self.emailField.autocorrectionType = .no
        self.emailField.returnKeyType = .next
        self.passwordField.autocorrectionType = .no
        self.passwordField.placeholder = "password".localize
        self.passwordField.delegate = self
        self.passwordField.returnKeyType = .done
        self.passwordField.isSecureTextEntry = true
        self.validationService = UPennValidationService(textFields: [ self.emailField, self.passwordField ])
        
        // Set up Buttons & Images
        self.upennBannerLogo.image = UPennImageAssets.UPennBannerTransparent
        self.autoFillButton.adjustsImageWhenHighlighted = false
        self.autoFillButton.setImage(UPennImageAssets.CheckedCheckBox, for: .selected)
        self.autoFillButton.setImage(UPennImageAssets.UnCheckedCheckBox, for: .normal)
        
        // Set up Touch Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleLoginAutoFill))
        tap.delegate = self
        tap.numberOfTapsRequired = 1
        self.rememberMeLabel.isUserInteractionEnabled = true
        self.rememberMeLabel.addGestureRecognizer(tap)
        self.rememberMeLabel.textColor = UIColor.upennDarkBlue
        
        // Set up Forgot Password
        self.forgotPasswordLabel.tintColor = UIColor.upennDarkBlue
    }
    
    @IBAction func pressedLogin(_ sender: Any) {
        self.login()
    }
    
    @IBAction func pressedAutoFillButton(_ sender: UIButton) {
        self.toggleLoginAutoFill()
    }
    
    @IBAction func pressedForgotPassword(_ sender: Any) {
        self.forgotPassword()
    }
    
    open func verifyFields() {
        self.loginButton.isEnabled = validationService.loginFieldsAreValid
    }
    
    open func viewDidAppear() {
        // TODO: Still Needed for UI?
        self.presenter.authenticationAutoFillCheck()
        verifyFields()
        self.presenter.attemptBiometricsAuthentication()
        self.autoFillButton.isSelected = self.presenter.shouldAutoFill
        self.updateView()
    }
    
    open func viewDidDisappear() {
        self.validationService.resetTextFields()
    }
    
    open func updateView() {
        // Setup Biometrics Button
        self.biometricsButtonView.configure("1", image: presenter.biometricsImage, delegate: self, enabled: presenter.biometricsEnabled)
    }
    
    open func login() {
        UPennActivityPresenter.Show(message: "Logging in.....")
        self.presenter.makeLoginRequest(username: self.emailField.text!, password: self.passwordField.text!)
    }
    // TODO: Still Needed for UI?
    @objc open func toggleLoginAutoFill() {
        if autoFillButton.isSelected && self.presenter.biometricsEnabled {
            self.present(self.rememberMeAlertController, animated: true, completion: nil)
            return
        }
        self.toggleRememberMe()
    }
    
    @objc open func textFieldDidChange(_ sender: Any) {
        verifyFields()
    }
    // TODO: Still Needed for UI?
    open func toggleRememberMe(_ enabled: Bool = false) {
        if enabled {
            self.autoFillButton.isSelected = enabled
            self.presenter.toggleShouldAutoFill(enabled)
            return
        }
        self.autoFillButton.isSelected = !self.autoFillButton.isSelected
        self.presenter.toggleShouldAutoFill(self.autoFillButton.isSelected)
    }
    
    open func advanceTextfields(textfield: UITextField) {
        let nextTag: NSInteger = textfield.tag + 1
        if let nextResponder: UIResponder = textfield.superview!.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textfield.resignFirstResponder()
            self.login()
        }
    }
    
    open func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics settings
         * 2. Toggle 'Remember Me' On
         */
        self.presenter.turnOnBiometricAuthSettings()
        self.toggleRememberMe(true)
    }
}

// MARK: - UPennIconButtonViewDelegate

extension UPennLoginViewController : UPennIconButtonDelegate {

    func pressedIconButton(identifier: String) {
        // Trigger biometrics
        self.presenter.attemptBiometricsAuthentication()
    }
    
}

// MARK: - UITextFieldDelegate

extension UPennLoginViewController : UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.advanceTextfields(textfield: textField)
        return true
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

// MARK: - LoginService Delegate

extension UPennLoginViewController : UPennLoginPresenterDelegate {
    
    open func didSuccessfullyLoginUser() {
        /*
         * 1. Trigger Logout timer
         * 2. Send username & PN deviceToken to server
         * 2. Check for 1st Launch & register Biometrics opt-in
         */
        // TODO: Move to Coordinator?
//        self.sendLoginNotification()
        UPennActivityPresenter.Dismiss()
        self.coordinator.didSuccessfullyLoginUser()
    }
    
    open func didReturnAutoFillCredentials(username: String, password: String) {
        self.emailField.text = username
    }
    
    open func didFailToLoginUser(errorStr: String) {
        UPennActivityPresenter.ShowError(message: errorStr)
    }

    open func registerForTouchIDAuthentication() {
         UPennActivityPresenter.Dismiss()
        self.present(self.touchIDAlertController, animated: true, completion: nil)
    }
    
    open func biometricsDidError(with message: String?) {
        UPennActivityPresenter.ShowError(message: message ?? "")
    }
    
    open func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        // Check if isFirstLogin - indicates user has opted-in to use biometrics, so must trigger settings updates
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
    }
}

// MARK: - Private

private extension UPennLoginViewController {
    
}

extension UPennLoginViewController : UIGestureRecognizerDelegate { }


