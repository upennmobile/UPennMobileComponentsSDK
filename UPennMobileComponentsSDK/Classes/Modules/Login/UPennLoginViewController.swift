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

public class UPennLoginViewController: UPennBasicViewController, Storyboarded /*UPennStoryboardedViewController UIViewController*/ {
    
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
        return UIAlertController()
    }()
    
    fileprivate lazy var rememberMeAlertController : UIAlertController = {
        return UIAlertController()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
//    public override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.setup()
//    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppear()
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewDidDisappear()
    }
    
    func setup() {
        // General
        // TODO: Not Needed? -- Will be injected when loginCoordinator is created self.logincoordinator.setLoginDelegate(loginDelegate: self)
//        self.biometricsService = UPennBiometricsAuthService(biometricsDelegate: self)
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
        // TODO: Remove? PPURLProvider.GoToForgotPassword()
    }
}

// MARK: - UPennIconButtonViewDelegate

extension UPennLoginViewController : UPennIconButtonDelegate {

    func pressedIconButton(identifier: String) {
        // Trigger biometrics
        self.loginPresenter.attemptBiometricsAuthentication()
    }
    
}

// MARK: - UITextFieldDelegate

extension UPennLoginViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.advanceTextfields(textfield: textField)
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

// MARK: - LoginService Delegate

extension UPennLoginViewController : UPennLoginPresenterDelegate {
    
    public func didSuccessfullyLoginUser() {
        /*
         * 1. Trigger Logout timer
         * 2. Send username & PN deviceToken to server
         * 2. Check for 1st Launch & register Biometrics opt-in
         */
        // TODO: Move to Coordinator?
//        self.sendLoginNotification()
        UPennActivityPresenter.Dismiss()
        self.loginCoordinator?.didSuccessfullyLoginUser()
    }
    
    public func didReturnAutoFillCredentials(username: String, password: String) {
        self.emailField.text = username
    }
    
    public func didFailToLoginUser(errorStr: String) {
        UPennActivityPresenter.ShowError(message: errorStr)
    }

    public func registerForTouchIDAuthentication() {
         UPennActivityPresenter.Dismiss()
        self.present(self.touchIDAlertController, animated: true, completion: nil)
    }
    
//    public func presentTouchIDRegistration() {
//        //
//    }
    
    public func biometricsDidError(with message: String?) {
        UPennActivityPresenter.ShowError(message: message ?? "")
    }
    
    public func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        // Check if isFirstLogin - indicates user has opted-in to use biometrics, so must trigger settings updates
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
    }
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
        self.loginPresenter.attemptBiometricsAuthentication()
        self.autoFillButton.isSelected = self.loginPresenter.shouldAutoFill
        self.updateView()
    }
    
    func viewDidDisappear() {
        self.validationService.resetTextFields()
    }
    
    func updateView() {
        // Setup Biometrics Button
        self.biometricsButtonView.configure("1", image: loginPresenter.biometricsImage, delegate: self, enabled: loginPresenter.biometricsEnabled)
    }
    
    func login() {
        UPennActivityPresenter.Show(message: "Logging in.....")
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
    
    func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics enabled On
         * 2. Toggle 'Remember Me' On
         * 3. Cache login credentials
         * 4. Trigger login notification
         */
//        self.loginPresenter.toggleBiometrics(true)
        self.loginPresenter.turnOnBiometricAuthSettings()
        self.toggleRememberMe(true)
    }
    
}

extension UPennLoginViewController : UIGestureRecognizerDelegate { }


