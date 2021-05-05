//
//  UPennLoginPresenter.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/24/21.
//

/**
 Abstract:
 Intermediates Login, Biometrics & Authentication functionality for a custom LoginViewController
 */

import Foundation

/// Intermediates Login, Biometrics & Authentication functionality for a custom LoginViewController
open class UPennLoginPresenter : UPennLoginPresentable {
    
    fileprivate var biometricsService: UPennBiometricsAuthenticationInterface!
    fileprivate var loginService: UPennLoginInterface!
    fileprivate var username = "", password = ""
    
    var loginDelegate : UPennLoginPresenterDelegate?
    
    public init(
        loginDelegate: UPennLoginPresenterDelegate) {
        self.loginDelegate = loginDelegate
        let requestService = UPennLoginNetworkingService(urlProvider: UPennURLProvider(rootURL: UPennApplicationSettings.RootURL, loginEndpoint: UPennApplicationSettings.LoginURL))
        self.loginService = UPennLoginService(requestService: requestService, loginDelegate: self)
        self.biometricsService = UPennBiometricsAuthService(biometricsDelegate: self)
    }

    // MARK: - UPennLoginInterface
    /// UPennLoginPresenter exposes Login functionality via this protocol conformance
    
    // MARK: Login Service
    
    open var isFirstLogin : Bool {
        self.loginService.isFirstLogin
    }
    
    open func setFirstLogin() {
        self.loginService.setFirstLogin()
    }
    
    open var userIsLoggedIn : Bool {
        self.loginService.userIsLoggedIn
    }
    
    open var shouldAutoFill: Bool {
        return self.loginService.shouldAutoFill
    }
    
    open func makeLoginRequest(username: String, password: String) {
        self.username = username; self.password = password
        self.loginService.makeLoginRequest(username: username, password: password)
    }
    
    open func authenticationAutoFillCheck() {
        self.loginService.authenticationAutoFillCheck()
    }
    
    open func toggleShouldAutoFill(_ autoFill: Bool) {
        self.loginService.toggleShouldAutoFill(autoFill)
    }
    
    open func cacheLoginCredentials(username: String, password: String) {
        self.loginService.cacheLoginCredentials(username: username, password: password)
    }
    
    open func attemptSilentLogin() {
        self.loginService.attemptSilentLogin()
    }
    
    open func logout() {
        self.loginService.logout()
    }

    // MARK: Biometrics Service
    
    open var touchIDOptInTitle: String {
        return self.biometricsService.touchIDOptInTitle
    }
    
    open var touchIDOptInMessage: String {
        return self.biometricsService.touchIDOptInMessage
    }
    
    open var touchIDConfirmed: String {
        return self.biometricsService.touchIDConfirmed
    }
    
    open var touchIDDeclined: String {
        return self.biometricsService.touchIDDeclined
    }
    
    open var biometricOptOutMessage: String {
        return self.biometricsService.biometricOptOutMessage
    }
    
    open var biometricsEnabled: Bool {
        return self.biometricsService.biometricsEnabled
    }
    
    open var biometricsImage: UIImage {
        return self.biometricsService.biometricsImage
    }
    
    open func completeTouchIDRegistration() {
        self.biometricsService.completeTouchIDRegistration()
    }
    
    open func toggleBiometrics(_ toggledOn: Bool) {
        self.biometricsService.toggleBiometrics(toggledOn)
    }
    
    open func attemptBiometricsAuthentication() {
        if self.loginService.shouldAutoFill {
            self.biometricsService.attemptBiometricsAuthentication()
        }
    }

    // MARK: - LoginService Delegate
    /// UPennLoginPresenter will respond to the Login Service via these interface methods
    
    open func didSuccessfullyLoginUser() {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
        
        /*
         * 1. Trigger Logout timer
         * 2. Send username & PN deviceToken to server
         * 2. Check for 1st Launch & register Biometrics opt-in
         */
        
        if self.isFirstLogin {
            self.biometricsService.registerForBiometricAuthentication()
            return
        }
        
        /*
         * Check if biometrics where enabled in Accounts before being properly registered
         */
        if self.biometricsService.enabledBiometricsBeforeRegistered {
            self.biometricsService.registerForBiometricAuthentication()
            return
        }
        self.loginDelegate?.didSuccessfullyLoginUser()
    }
    
    open func didReturnAutoFillCredentials(username: String, password: String) {
        self.loginDelegate?.didReturnAutoFillCredentials(username: username, password: password)
    }
    
    open func didFailToLoginUser(errorStr: String) {
        self.loginDelegate?.didFailToLoginUser(errorStr: errorStr)
    }

    // MARK: - BiometricsDelegate

    /// UPennLoginPresenter will respond to Biometrics Service via these interface methods
    open func registerForTouchIDAuthentication() {
        self.loginDelegate?.registerForTouchIDAuthentication()
    }
    
    open func registerForFaceIDAuthentication() {
        // TODO: Send message to LoginVC to display UPennProgressHUD -- SVProgressHUD.dismiss()
        self.biometricsService.utilizeBiometricAuthentication(turnOnBiometrics: true)
    }
    
    open func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics enabled On
         * 2. Toggle 'Remember Me' On
         * 3. Cache login credentials
         * 4. Trigger login notification
         */
        self.biometricsService.toggleBiometrics(true)
        self.loginService.toggleShouldAutoFill(true)
        self.loginService.cacheLoginCredentials(username: self.username, password: self.password)
//        self.sendLoginNotification() TODO: Remove?
        self.loginDelegate?.didSuccessfullyLoginUser()
    }
    
    open func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        // Check if isFirstLogin - indicates user has opted-in to use biometrics, so must trigger settings updates
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
        self.attemptSilentLogin()
    }
    
    open func biometricsDidError(with message: String?, shouldContinue: Bool) {
        // Check if isFirstLogin - indicates user has canceled opt-in to biometrics, so complete login and push to ChangeRequestVC
        if shouldContinue {
            self.loginDelegate?.didSuccessfullyLoginUser()
            return
        }
        guard let m = message else { return }
        self.loginDelegate?.biometricsDidError(with: m)
    }
}
