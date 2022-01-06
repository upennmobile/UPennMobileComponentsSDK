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
    
    open var biometricsService: UPennBiometricsAuthenticationInterface!
    open var loginService: UPennLoginInterfaceDelegated!
    open var username = "", password = ""
    
    open var presenterDelegate : UPennLoginPresenterDelegate?
    
    public init(
        presenterDelegate: UPennLoginPresenterDelegate,
        loginService: UPennLoginInterfaceDelegated?=nil,
        biometricsService: UPennBiometricsAuthenticationInterface?=nil) {
        self.presenterDelegate = presenterDelegate
        // TODO: Dependency-inject all the services via init?
        
        if let _login = loginService {
            self.loginService = _login
            self.loginService.loginDelegate = self
        } else {
            let requestService = UPennLoginNetworkService()
            self.loginService = UPennLoginService(requestService: requestService, loginDelegate: self)
        }
        if let _biometrics = biometricsService {
            self.biometricsService = _biometrics
            self.biometricsService.biometricsDelegate = self
        } else {
            self.biometricsService = UPennBiometricsAuthService(biometricsDelegate: self)
        }
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
    
    open var toggleTitleText: String {
        return self.biometricsService.toggleTitleText
    }
    
    open var biometricsAvailable: Bool {
        return self.biometricsService.biometricsAvailable
    }
    
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
        self.presenterDelegate?.didSuccessfullyLoginUser()
    }
    
    open func didReturnAutoFillCredentials(username: String, password: String) {
        self.presenterDelegate?.didReturnAutoFillCredentials(username: username, password: password)
    }
    
    open func didFailToLoginUser(errorStr: String) {
        self.presenterDelegate?.didFailToLoginUser(errorStr: errorStr)
    }

    // MARK: - BiometricsDelegate

    /// UPennLoginPresenter will respond to Biometrics Service via these interface methods
    open func registerForTouchIDAuthentication() {
        self.presenterDelegate?.registerForTouchIDAuthentication()
    }
    
    open func registerForFaceIDAuthentication() {
        // TODO: Send message to LoginVC to display UPennProgressHUD -- SVProgressHUD.dismiss()
        self.biometricsService.utilizeBiometricAuthentication(turnOnBiometrics: true)
    }
    
    open func turnOnBiometricAuthSettings() {
        /*
         * 1. Toggle biometrics enabled On
         * 2. Toggle autoFill On
         * 3. Cache login credentials
         * 4. Fire successful login delegate callback
         */
        self.biometricsService.toggleBiometrics(true)
        self.loginService.toggleShouldAutoFill(true)
        self.loginService.cacheLoginCredentials(username: self.username, password: self.password)
        self.presenterDelegate?.didSuccessfullyLoginUser()
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
            self.presenterDelegate?.didSuccessfullyLoginUser()
            return
        }
        guard let m = message else { return }
        self.presenterDelegate?.biometricsDidError(with: m)
    }
}
