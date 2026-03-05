//
//  AppDelegate.swift
//  nope
//
//  Created by Sushant Verma on 5/3/2026.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    let logger = AutoLogger.unifiedLogger()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        logger.info("App launched")
        initFirebase()
        return true
    }
}
