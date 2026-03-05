//
//  AppDelegate+firebase.swift
//  nope
//
//  Created by Sushant Verma on 5/3/2026.
//

import FirebaseCore

extension AppDelegate {
    func initFirebase() {
        logger.info("Initializing Firebase")
        FirebaseApp.configure()
    }
}
