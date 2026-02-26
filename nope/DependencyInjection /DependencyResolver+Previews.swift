//
//  DependencyResolver+Previews.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

extension DependencyResolver {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        resolver.register(FavoritesService.self, resolved: .singleton) { resolver in
            InMemoryFavoritesService()
        }
        return resolver
    }
}
