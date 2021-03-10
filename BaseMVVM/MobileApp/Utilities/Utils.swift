//
//  Utils.swift
//  BaseMVVM
//
//  Created by HOANDHTB on 3/10/21.
//

import Foundation
import UIKit

// MARK: App version

let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String

func callPhoneNumber(_ phone: String) {
    let phoneLink = "tel://\(phone)"
    if let url = URL(string: phoneLink) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

func openFromRootView(_ viewController: UIViewController?) {
    if #available(iOS 13.0, *) {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = viewController
    } else {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
