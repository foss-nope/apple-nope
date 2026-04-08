//
//  DependencyContainer+Previews.swift
//  nope
//
//  Created by Sushant Verma on 8/4/2026.
//

import SwiftDependencyInjection

extension DependencyContainer {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyContainer {
        let resolver = DependencyContainer.forApp()
        resolver.register(FavoritesService.self, registration: .singleton) {
            InMemoryFavoritesService()
        }
        resolver.register(PasteboardWriting.self, registration: .singleton) {
            InMemoryPasteboard()
        }
        return resolver
    }
}
