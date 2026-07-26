//
//  DependencyContainer+Previews.swift
//  nope
//
//  Created by Sushant Verma on 8/4/2026.
//

import SwiftDependencyInjection
import UIKit

extension DependencyContainer {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyContainer {
        let resolver = DependencyContainer.forApp()
        resolver.register(FavoritesService.self, registration: .singleton) {
            InMemoryFavoritesService()
        }
        resolver.register(UIPasteboard.self, registration: .singleton) {
            UIPasteboard.withUniqueName()
        }
        return resolver
    }
}
