//
//  DependencyResolver+UITests.swift
//  nope
//
//  Created by Sushant Verma on 23/2/2026.
//

extension DependencyResolver {
    /// For SwiftUI Preview
    static func forUITests() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        resolver.register(FavoritesService.self, resolved: .singleton) { resolver in
            InMemoryFavoritesService()
        }
        return resolver
    }
}
