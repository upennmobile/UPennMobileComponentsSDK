//
//  Storyboarded.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 2/24/21.
//

import Foundation
import UIKit

public protocol Storyboarded : AnyObject {
    static var StoryboardName : String { get }
}

public extension Storyboarded where Self: UIViewController {
    static var StoryboardName: String {
        return String(describing: self)
    }
        
    static func Instantiate(_ bundleContext: Bundle.Context) -> Self {
        var sbd : UIStoryboard?
        switch bundleContext {
        case .Main:
            sbd = UIStoryboard(name: StoryboardName, bundle: nil)
        case .SDK:
            sbd = UIStoryboard(name: StoryboardName, bundle: Bundle.UPennSDKResourcesProvider())
        }
        guard
            let storyboard = sbd,
            let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(StoryboardName)")
        }
        return vc
    }
}

/// ViewController that provides built-in inheritance from UPennBasicViewController & Storyboarded conformance
open class UPennStoryboardViewController : UPennBasicViewController, Storyboarded { }
