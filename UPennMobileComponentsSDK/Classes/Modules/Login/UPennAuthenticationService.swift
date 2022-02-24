//
//  UPennAuthenticationService.swift
//  Penn Chart Live
//
//  Created by Rashad Abdul-Salam on 3/12/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import JWTDecode
import UIKit

open class UPennAuthenticationService {
    
    /*
     TODO:
     Update with 'static var JWTDict : [String:Any]' which will be a dictionary to hold info like DisplayName, AthenaUserId etc, so that it can be easily updated to hold custom information within separate applications
     */
    public static var AuthToken: String?
    public static var AthenaUserId: String?
    public static var DisplayName: String?
    public static let AutoLoginKey  = UPennNameSpacer.MakeKey("shouldAutoLogin")
    public static let AutoFillKey   = UPennNameSpacer.MakeKey("shouldAutoFill")
    public static let UsernameKey   = UPennNameSpacer.MakeKey("username")
    public static let LoginCountKey = UPennNameSpacer.MakeKey("loginCountKey")
    public static var IsAuthenticated = false
    public static var ParseJWTTokenForUserCreds = true
    public static var ShouldAutoLogin : Bool {
        return UserDefaults.standard.value(forKey: AutoLoginKey) as? Bool ?? false
    }
    
    public static var ShouldAutoFill : Bool {
        return UserDefaults.standard.value(forKey: AutoFillKey) as? Bool ?? false
    }
    
    public static var IsFirstLogin : Bool {
        return UserDefaults.standard.value(forKey: LoginCountKey) as? Bool ?? true
    }
    public static var PennUserName: String = ""
    public static func storeAuthenticationCredentials(
        token: String,
        username: String,
        password: String) {
        AuthToken = token
        IsAuthenticated = true
        
        // Parse JWT
        if Self.ParseJWTTokenForUserCreds {
            self.parseJWTForInfo(jsonWebToken: token)
        }
        
        // Check if shouldAutoFill, keychain-cache the in-coming credentials
        if ShouldAutoFill {
            self.cacheAuthenticationCredentials(username: username, password: password)
        }
    }
    
    public static func cacheAuthenticationCredentials(username: String, password: String) {
        
        // Store pennUsername
        UserDefaults.standard.setValue(username, forKey: UsernameKey)
        
        do {
            
            // This is a new account, create a new keychain item with the account name.
            let passwordItem = UPennKeychainPasswordItem(
                service: UPennKeychainConfiguration.serviceName,
                account: username,
                accessGroup: UPennKeychainConfiguration.accessGroup)
            
            // Save the password for the new item.
            try passwordItem.savePassword(password)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }
    
    public static var hasCachedAuthCredentials : Bool {
        return !PennUserName.isEmpty
    }
    
    public static func checkAuthenticationCache(completion:(_ username: String?, _ password: String?)->Void) {
        
        guard let username = UserDefaults.standard.value(forKey: UsernameKey) as? String else {
            completion(nil,nil)
            return
        }
        
        do {
            let passwordItem = UPennKeychainPasswordItem(
                service: UPennKeychainConfiguration.serviceName,
                account: username,
                accessGroup: UPennKeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            completion(username,keychainPassword)
        }
        catch {
            completion(nil,nil)
        }
    }
    
    public static func toggleShouldAutoLogin(_ autoLogin: Bool) {
        UserDefaults.standard.set(autoLogin, forKey: AutoLoginKey)
    }
    
    public static func toggleShouldAutoFill(_ autoFill: Bool) {
        UserDefaults.standard.set(autoFill, forKey: AutoFillKey)
    }
    
    public static func setFirstLogin() {
        UserDefaults.standard.set(false, forKey: LoginCountKey)
    }
    
    public static func logout() {
        IsAuthenticated = false
        AuthToken = nil
    }
}

private extension UPennAuthenticationService {
    
    // TODO: Update to parse 'AuthToken' for custom string-key var and add key-value pair to JWTDict static var
    static func parseJWTForInfo(jsonWebToken: String) {
        /* Sample JWT Values
         {
         "unique_name": "penn_username",
         "nbf": 123456789,
         "exp": 123456789,
         "iat": 123456789
         }
         */
        
        do {
            let jwt = try decode(jwt: jsonWebToken)
            let athenaUserIdClaim = jwt.claim(name: "AthenaUserId")
            let uniqueName = jwt.claim(name: "unique_name")
            let displayNameClaim = jwt.claim(name: "DisplayName")
            
            if
                let name = uniqueName.string,
                let displayName = displayNameClaim.string,
                let athenaUserId = athenaUserIdClaim.string
            {
                PennUserName = name
                AthenaUserId = athenaUserId
                DisplayName = displayName
            }
        } catch {
            // Handle Error
            fatalError("Error parsing JWT - \(error)")
        }
    }
}
