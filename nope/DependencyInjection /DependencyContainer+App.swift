//
//  DependencyContainer+App.swift
//  nope
//
//  Created by Sushant Verma on 8/4/2026.
//

import SwiftDependencyInjection

extension DependencyContainer {
    /// For the app
    static func forApp() -> DependencyContainer {
        let resolver = DependencyContainer()
        resolver.register(ReasonsService.self, registration: .singleton) {
            JsonReasonsService(resourceName: "reasons")
        }
        resolver.register(FavoritesService.self, registration: .singleton) {
            DefaultsFavoritesService()
        }
        resolver.register(PasteboardWriting.self, registration: .singleton) {
            SystemPasteboard()
        }
        return resolver
    }
}
