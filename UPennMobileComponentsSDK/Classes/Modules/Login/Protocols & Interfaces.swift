//
//  Protocols & Interfaces.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 4/25/21.
//

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

/// Protocol to ensure conforming object includes a 'UPennLoginServiceDelegate' var
public protocol UPennLoginDelegated {
    var loginDelegate: UPennLoginServiceDelegate? { get set }
}

/// Interface for an object/component to make/respond to login attempts, and handle various authentication events
public protocol UPennLoginInterface : UPennLoginRequestable, UPennLoginCoordinatable {
    var shouldAutoFill : Bool { get }
    var isFirstLogin : Bool { get }
    func setFirstLogin()
    func authenticationAutoFillCheck()
    func toggleShouldAutoFill(_ autoFill: Bool)
    func cacheLoginCredentials(username: String, password: String)
    func attemptSilentLogin()
}

/// Protocol to ensure conforming 'UPennLoginInterface' object includes a 'UPennLoginServiceDelegate' var
public protocol UPennLoginInterfaceDelegated : UPennLoginDelegated, UPennLoginInterface { }

/// Delegation methods for LoginVC  to respond to Login Presenter
public protocol UPennLoginPresenterDelegate : UPennLoginServiceDelegate {
    func registerForTouchIDAuthentication()
    func biometricsSuccessfullyAuthenticated(turnOnBiometrics: Bool)
    func biometricsDidError(with message: String?)
//    func loginIsDismissed()
}

/// Interface for for View object to send messages to Login Presenter
public protocol UPennLoginBiometricsInterface {
    var touchIDOptInTitle : String { get }
    var touchIDOptInMessage : String { get }
    var touchIDConfirmed : String { get }
    var touchIDDeclined : String { get }
    var biometricOptOutMessage : String { get }
    var toggleTitleText : String { get }
    var biometricsImage : UIImage { get }
    var biometricsEnabled : Bool { get }
    var biometricsAvailable : Bool { get }
    func completeTouchIDRegistration()
    func turnOnBiometricAuthSettings()
    func toggleBiometrics(_ toggledOn: Bool)
    func attemptBiometricsAuthentication()
}

/// Interface providing an object with TouchID/FaceID Authentication
public protocol UPennBiometricsAuthenticationInterface: UPennLoginBiometricsInterface {
    var biometricsDelegate : UPennBiometricsDelegate? { get set }
    func registerForBiometricAuthentication()
    var enabledBiometricsBeforeRegistered : Bool { get }
    func utilizeBiometricAuthentication(turnOnBiometrics: Bool)
    func attemptBiometricsAuthentication()
}

/// Interface that enables an object to combine required functionality from UPennLoginInterface and UPennLoginBiometricsInterface
public protocol UPennLoginPlusBiometricsInterface : UPennLoginInterface, UPennLoginBiometricsInterface { }

/// Interface that defines comprehensive functionality for a Login Presenter
public protocol UPennLoginPresentable : UPennLoginPlusBiometricsInterface, UPennLoginServiceDelegate, UPennBiometricsDelegate { }
