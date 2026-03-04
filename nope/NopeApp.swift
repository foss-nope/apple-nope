//
//  NopeApp.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import SwiftUI

@main
struct NopeApp: App {
    @StateObject private var resolver: DependencyResolver  // ⬅️ Persist for app lifecycle

    init() {
        let isRunningXcodePreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        let isRunningUITest = ProcessInfo.processInfo.environment["CUSTOM_RUNNING_UI_TEST"] == "1"
        let resolver: DependencyResolver
        if isRunningXcodePreviews {
            resolver = DependencyResolver.forPreview()
        } else if isRunningUITest {
            resolver = DependencyResolver.forUITests()
        } else {
            resolver = DependencyResolver.forApp()
        }

        _resolver = .init(wrappedValue: resolver)
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
