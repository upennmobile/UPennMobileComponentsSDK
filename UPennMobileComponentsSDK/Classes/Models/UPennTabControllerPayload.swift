//
//  UPennTabControllerPayload.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 5/25/21.
//

import Foundation

/// Object that bundles array of UPennTabItems & Navigation controllers for easy transport & unbundling
open class UPennTabControllerPayload {
    
    open var tabBarItems: Array<UPennTabBarItem>
    open var navControllers: Array<UINavigationController>
    
    public init(navControllers: [UINavigationController], tabBarItems: [UPennTabBarItem]) {
        self.tabBarItems = tabBarItems; self.navControllers = navControllers
    }
}
