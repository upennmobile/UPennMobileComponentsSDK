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
import UPennMobileComponentsSDK

class UPennLoginViewController: UPennBasicViewController, Storyboarded {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: PrimaryCTAButton!
    @IBOutlet weak var autoFillButton: PrimaryCTAButtonText!
    @IBOutlet weak var titleLabel: BannerLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rememberMeLabel: ContactDepartmentLabel!
    @IBOutlet weak var forgotPasswordLabel: UIButton!
    
    fileprivate var validationService: UPennValidationService!
    fileprivate var keyboardService: UPennKeyboardService!
//    fileprivate var biometricsService: UPennBiometricsAuthService!
    // TODO: Inject via UPennMainCoordinator - ***
    var loginPresenter : UPennLoginPlusBiometricsInterface!
    var loginCoordinator : UPennLoginCoordinator!
//    var loginPresenter : UPennLoginBiometricsInterface!
    // ***
    // TODO: Not Needed?
    fileprivate var isFirstLogin : Bool {
        return UPennAuthenticationService.IsFirstLogin
    }
    
    fileprivate lazy var touchIDAlertController : UIAlertController = {
        let alertController = UIAlertController(
            title: self.loginPresenter.touchIDOptInTitle,
            message: self.loginPresenter.touchIDOptInMessage,
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: self.loginPresenter.touchIDDeclined, style: .cancel, handler: {
            alert -> Void in
            // Force biometrics off, and complete login flow to close-out LoginVC
            self.loginPresenter.toggleBiometrics(false)
//            self.sendLoginNotification()
            self.loginCoordinator?.didSuccessfullyLoginUser()
        })
        let useTouchIDAction = UIAlertAction(title: self.loginPresenter.touchIDConfirmed, style: .default, handler: {
            alert -> Void in
            // Turn on Biometrics Settings & complete Touch ID registration to ensure no repeat launches of Touch ID alert
            self.turnOnBiometricAuthSettings()
            self.loginPresenter.completeTouchIDRegistration()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(useTouchIDAction)
        return alertController
    }()
    
    fileprivate lazy var rememberMeAlertController : UIAlertController = {
        let alertController = UIAlertController(
            title: self.loginPresenter.biometricOptOutMessage,
            message: "",
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil)
        let disableRememberMe = UIAlertAction(title: "OK".localize, style: .default, handler: {
            alert -> Void in
            self.loginPresenter.toggleBiometrics(false)
            self.toggleRememberMe()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(disableRememberMe)
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppear()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewDidDisappear()
    }
    
    func setup() {
        // General
        // TODO: Not Needed? -- Will be injected when loginCoordinator is created self.logincoordinator.setLoginDelegate(loginDelegate: self)
//        self.biometricsService = UPennBiometricsAuthService(biometricsDelegate: self)
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
        
        // Set up Buttons
        self.autoFillButton.adjustsImageWhenHighlighted = false
//        self.autoFillButton.setImage(#imageLiteral(resourceName: "checked"), for: .selected)
//        self.autoFillButton.setImage(#imageLiteral(resourceName: "un_checked"), for: .normal)
        
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
        // TODO: Remove? PPURLProvider.GoToForgotPassword()
    }
}

// MARK: - UITextFieldDelegate

extension UPennLoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.advanceTextfields(textfield: textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

// MARK: - LoginService Delegate

extension UPennLoginViewController : UPennLoginPresenterDelegate {
    
    func didSuccessfullyLoginUser() {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
        
        /*
         * 1. Trigger Logout timer
         * 2. Send username & PN deviceToken to server
         * 2. Check for 1st Launch & register Biometrics opt-in
         */
        // TODO: Fire different method? self.logincoordinator.resetLogoutTimer()
        
//        if self.isFirstLogin {
//            self.biometricsService.registerForBiometricAuthentication()
//            return
//        }
        
        /*
         * Check if biometrics where enabled in Accounts before being properly registered
         */
        // TODO: Not Needed?
//        if self.biometricsService.enabledBiometricsBeforeRegistered {
//            self.biometricsService.registerForBiometricAuthentication()
//            return
//        }
        // TODO: Move to Coordinator?
//        self.sendLoginNotification()
        self.loginCoordinator?.didSuccessfullyLoginUser()
    }
    
    func didReturnAutoFillCredentials(username: String, password: String) {
        self.emailField.text = username
    }
    
    func didFailToLoginUser(errorStr: String) {
        // TODO: Replace w/ UPennProgressHUD
//        SVProgressHUD.showError(withStatus: errorStr)
    }

    func registerForTouchIDAuthentication() {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
        self.present(self.touchIDAlertController, animated: true, completion: nil)
    }
    
    func presentTouchIDRegistration() {
        //
    }
    
    func biometricsDidError(with message: String?) {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.showError(withStatus: message)
    }
    
//    func registerForFaceIDAuthentication() {
//        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
//        self.biometricsService.utilizeBiometricAuthentication(turnOnBiometrics: true)
//    }
    
    func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        // Check if isFirstLogin - indicates user has opted-in to use biometrics, so must trigger settings updates
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.show(withStatus: "Logging in.....")
//        self.logincoordinator.attemptSilentLogin()
    }
    
//    func biometricsDidError(with message: String?, shouldContinue: Bool) {
//        // Check if isFirstLogin - indicates user has canceled opt-in to biometrics, so complete login and push to ChangeRequestVC
//        if shouldContinue {
//            self.sendLoginNotification()
//            return
//        }
//        guard let m = message else { return }
//        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.showError(withStatus: m)
//    }
}

// MARK: - Private

private extension UPennLoginViewController {
    
    func verifyFields() {
        self.loginButton.isEnabled = validationService.loginFieldsAreValid
    }
    
    func viewDidAppear() {
        // TODO: Still Needed for UI?
        self.loginPresenter.authenticationAutoFillCheck()
        verifyFields()
        self.attemptBiometricsPresentation()
        self.autoFillButton.isSelected = self.loginPresenter.shouldAutoFill
    }
    
    func viewDidDisappear() {
        self.validationService.resetTextFields()
    }
    
    func login() {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.show(withStatus: "Logging in.....")
        self.loginPresenter.makeLoginRequest(username: self.emailField.text!, password: self.passwordField.text!)
    }
    // TODO: Still Needed for UI?
    @objc func toggleLoginAutoFill() {
        if autoFillButton.isSelected && self.loginPresenter.biometricsEnabled {
            self.present(self.rememberMeAlertController, animated: true, completion: nil)
            return
        }
        self.toggleRememberMe()
    }
    
    @objc func textFieldDidChange(_ sender: Any) {
        verifyFields()
    }
    // TODO: Still Needed for UI?
    func toggleRememberMe(_ enabled: Bool = false) {
        if enabled {
            self.autoFillButton.isSelected = enabled
            self.loginPresenter.toggleShouldAutoFill(enabled)
            return
        }
        self.autoFillButton.isSelected = !self.autoFillButton.isSelected
        self.loginPresenter.toggleShouldAutoFill(self.autoFillButton.isSelected)
    }
    
    func advanceTextfields(textfield: UITextField) {
        let nextTag: NSInteger = textfield.tag + 1
        if let nextResponder: UIResponder = textfield.superview!.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textfield.resignFirstResponder()
            self.login()
        }
    }
    
    func attemptBiometricsPresentation() {
//        if self.logincoordinator.shouldAutoFill {
//            self.biometricsService.attemptBiometricsAuthentication()
//        }
    }
    
    func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics enabled On
         * 2. Toggle 'Remember Me' On
         * 3. Cache login credentials
         * 4. Trigger login notification
         */
        self.loginPresenter.toggleBiometrics(true)
        self.toggleRememberMe(true)
//        self.logincoordinator.cacheLoginCredentials(username: emailField.text!, password: passwordField.text!)
//        self.sendLoginNotification()
        self.loginCoordinator?.didSuccessfullyLoginUser()
    }
    
}

extension UPennLoginViewController : UIGestureRecognizerDelegate { }


