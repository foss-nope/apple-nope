//
//  DependencyResolver+App.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

extension DependencyResolver {
    /// For the app
    static func forApp() -> DependencyResolver {
        let resolver = DependencyResolver.createEmpty()
        resolver.register(ReasonsService.self, resolved: .singleton) { _ in
            ReasonsService()
        }
        resolver.register(FavoritesService.self, resolved: .singleton) { resolver in
            InMemoryFavoritesService()
        }
        return resolver
    }
}
