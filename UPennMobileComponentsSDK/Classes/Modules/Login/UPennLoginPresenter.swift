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

/// Primary Interface for an object like a MainCoordinator to interact w/ a LoginCoordinator
public protocol UPennLoginCoordinatable {
    var userIsLoggedIn : Bool { get }
    func logout()
}
/// Delegation allowing for an object to respond to Login events
public protocol UPennLoginCoordinatorDelegate {
    func didSuccessfullyLoginUser()
}

/// Interface for an object to repond to Login requests
public protocol UPennLoginRequestable {
    func makeLoginRequest(username: String, password: String)
}

public protocol UPennLoginInterface : UPennLoginRequestable, UPennLoginCoordinatable {
    var shouldAutoFill : Bool { get }
    var isFirstLogin : Bool { get }
    func setFirstLogin()
    func authenticationAutoFillCheck()
    func toggleShouldAutoFill(_ autoFill: Bool)
    func cacheLoginCredentials(username: String, password: String)
    func attemptSilentLogin()
}

/// Delegation methods for LoginVC  to respond to Login Presenter
public protocol UPennLoginPresenterDelegate : UPennLoginServiceDelegate {
    func registerForTouchIDAuthentication()
//    func presentTouchIDRegistration()
    func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool)
    func biometricsDidError(with message: String?)
}
/// Interface for for View object to send messages to Login Presenter
public protocol UPennLoginBiometricsInterface {
    var touchIDOptInTitle : String { get }
    var touchIDOptInMessage : String { get }
    var touchIDConfirmed : String { get }
    var touchIDDeclined : String { get }
    var biometricOptOutMessage : String { get }
    var biometricsImage : UIImage { get }
    var biometricsEnabled : Bool { get }
    func completeTouchIDRegistration()
    func turnOnBiometricAuthSettings()
    func toggleBiometrics(_ toggledOn: Bool)
    func attemptBiometricsAuthentication()
}

/// Interface providing an object with TouchID/FaceID Authentication
public protocol UPennBiometricsAuthenticationInterface: UPennLoginBiometricsInterface {
    func registerForBiometricAuthentication()
    var enabledBiometricsBeforeRegistered : Bool { get }
    func utilizeBiometricAuthentication(turnOnBiometrics: Bool)
    func attemptBiometricsAuthentication()
}

/// Interface that enables an object to combine required functionality from UPennLoginInterface and UPennLoginBiometricsInterface
public protocol UPennLoginPlusBiometricsInterface : UPennLoginInterface, UPennLoginBiometricsInterface { }

//protocol UPennLoginPresenterDelegate : UPennLoginServiceDelegate & UPennLoginPresentable { }

/// Intermediates Login, Biometrics & Authentication functionality for a custom LoginViewController
public class UPennLoginPresenter {
    
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
}

// MARK: - UPennLoginInterface
/// UPennLoginPresenter exposes Login functionality via this protocol conformance
extension UPennLoginPresenter : UPennLoginPlusBiometricsInterface {
    
    // MARK: Login Service
    
    public var isFirstLogin : Bool {
        self.loginService.isFirstLogin
    }
    
    public func setFirstLogin() {
        self.loginService.setFirstLogin()
    }
    
    public var userIsLoggedIn : Bool {
        self.loginService.userIsLoggedIn
    }
    
    public var shouldAutoFill: Bool {
        return self.loginService.shouldAutoFill
    }
    
    public func makeLoginRequest(username: String, password: String) {
        self.username = username; self.password = password
        self.loginService.makeLoginRequest(username: username, password: password)
    }
    
    public func authenticationAutoFillCheck() {
        self.loginService.authenticationAutoFillCheck()
    }
    
    public func toggleShouldAutoFill(_ autoFill: Bool) {
        self.loginService.toggleShouldAutoFill(autoFill)
    }
    
    public func cacheLoginCredentials(username: String, password: String) {
        self.loginService.cacheLoginCredentials(username: username, password: password)
    }
    
    public func attemptSilentLogin() {
        self.loginService.attemptSilentLogin()
    }
    
    public func logout() {
        self.loginService.logout()
    }

    // MARK: Biometrics Service
    
    public var touchIDOptInTitle: String {
        return self.biometricsService.touchIDOptInTitle
    }
    
    public var touchIDOptInMessage: String {
        return self.biometricsService.touchIDOptInMessage
    }
    
    public var touchIDConfirmed: String {
        return self.biometricsService.touchIDConfirmed
    }
    
    public var touchIDDeclined: String {
        return self.biometricsService.touchIDDeclined
    }
    
    public var biometricOptOutMessage: String {
        return self.biometricsService.biometricOptOutMessage
    }
    
    public var biometricsEnabled: Bool {
        return self.biometricsService.biometricsEnabled
    }
    
    public var biometricsImage: UIImage {
        return self.biometricsService.biometricsImage
    }
    
    public func completeTouchIDRegistration() {
        self.biometricsService.completeTouchIDRegistration()
    }
    
    public func toggleBiometrics(_ toggledOn: Bool) {
        self.biometricsService.toggleBiometrics(toggledOn)
    }
    
    public func attemptBiometricsAuthentication() {
        if self.loginService.shouldAutoFill {
            self.biometricsService.attemptBiometricsAuthentication()
        }
    }
}

// MARK: - LoginService Delegate
/// UPennLoginPresenter will respond to the Login Service via these interface methods
extension UPennLoginPresenter : UPennLoginServiceDelegate {
    
    public func didSuccessfullyLoginUser() {
        // TODO: Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
        
        /*
         * 1. Trigger Logout timer
         * 2. Send username & PN deviceToken to server
         * 2. Check for 1st Launch & register Biometrics opt-in
         */
        // TODO: Fire different method? self.loginCoordinator.resetLogoutTimer()
        
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
        // TODO: Send back up to LoginCoordinator? self.sendLoginNotification() 
        self.loginDelegate?.didSuccessfullyLoginUser()
    }
    
    public func didReturnAutoFillCredentials(username: String, password: String) {
        self.loginDelegate?.didReturnAutoFillCredentials(username: username, password: password)
    }
    
    public func didFailToLoginUser(errorStr: String) {
        // TODO: Propagate up to LoginVC to display error SVProgressHUD.showError(withStatus: errorStr)
        self.loginDelegate?.didFailToLoginUser(errorStr: errorStr)
    }
}

// MARK: - BiometricsDelegate

/// UPennLoginPresenter will respond to Biometrics Service via these interface methods
extension UPennLoginPresenter : UPennBiometricsDelegate {
    public func registerForTouchIDAuthentication() {
        // TODO: Propagate message up to LoginVC/Coordinator to handle presentation
        // Replace w/ UPennProgressHUD SVProgressHUD.dismiss()
//        self.present(self.touchIDAlertController, animated: true, completion: nil)
//        self.loginDelegate?.presentTouchIDRegistration()
        self.loginDelegate?.registerForTouchIDAuthentication()
    }
    
    public func registerForFaceIDAuthentication() {
        // TODO: Send message to LoginVC to display UPennProgressHUD -- SVProgressHUD.dismiss()
        self.biometricsService.utilizeBiometricAuthentication(turnOnBiometrics: true)
    }
    
    public func turnOnBiometricAuthSettings() {
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
    
    public func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool) {
        // Check if isFirstLogin - indicates user has opted-in to use biometrics, so must trigger settings updates
        if turnOnBiometrics {
            self.turnOnBiometricAuthSettings()
            return
        }
        // TODO: Propagate up to LoginVC to display UPennProgressHUD SVProgressHUD.show(withStatus: "Logging in.....")
//        self.loginDelegate?.presentLoginInProgress() TODO: Not Needed?
        self.attemptSilentLogin()
    }
    
    public func biometricsDidError(with message: String?, shouldContinue: Bool) {
        // Check if isFirstLogin - indicates user has canceled opt-in to biometrics, so complete login and push to ChangeRequestVC
        if shouldContinue {
            // TODO: Propogate message up to LoginCoordinator self.sendLoginNotification()
            self.loginDelegate?.didSuccessfullyLoginUser()
            return
        }
        guard let m = message else { return }
        self.loginDelegate?.biometricsDidError(with: m)
    }
}
