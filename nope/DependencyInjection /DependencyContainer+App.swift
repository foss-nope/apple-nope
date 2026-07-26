//
//  DependencyContainer+App.swift
//  nope
//
//  Created by Sushant Verma on 8/4/2026.
//

import SwiftDependencyInjection
import UIKit

extension DependencyContainer {
    /// For the app
    static func forApp() -> DependencyContainer {
        let resolver = DependencyContainer()
        resolver.register(ReasonsService.self, registration: .singleton) {
            JsonReasonsService()
        }
        resolver.register(FavoritesService.self, registration: .singleton) {
            DefaultsFavoritesService()
        }
        resolver.register(UIPasteboard.self, registration: .singleton) {
            UIPasteboard.general
        }
        return resolver
    }
}
