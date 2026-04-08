//
//  NopeApp.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import SwiftUI
import SwiftDependencyInjection

@main
struct NopeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    private let resolver: DependencyContainer  // ⬅️ Persist for app lifecycle

    init() {
        let isRunningXcodePreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        let isRunningUITest = ProcessInfo.processInfo.environment["CUSTOM_RUNNING_UI_TEST"] == "1"
        if isRunningXcodePreviews {
            resolver = DependencyContainer.forPreview()
        } else if isRunningUITest {
            resolver = DependencyContainer.forUITests()
        } else {
            resolver = DependencyContainer.forApp()
        }
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                RandomReasonTabContent(resolver)
                FavoritesView(resolver)
                AboutView()
            }
        }
    }
}
