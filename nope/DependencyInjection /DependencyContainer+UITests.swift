//
//  DependencyContainer+UITests.swift
//  nope
//
//  Created by Sushant Verma on 8/4/2026.
//

import SwiftDependencyInjection

extension DependencyContainer {
    /// For Automated UITests
    static func forUITests() -> DependencyContainer {
        let resolver = DependencyContainer.forApp()
        resolver.register(FavoritesService.self, registration: .singleton) {
            InMemoryFavoritesService()
        }
        return resolver
    }
}
