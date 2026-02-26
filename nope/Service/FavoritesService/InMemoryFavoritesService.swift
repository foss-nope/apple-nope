//
//  InMemoryFavoritesService.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import Combine

class InMemoryFavoritesService: FavoritesService {

    private let logger = AutoLogger.unifiedLogger()

    @Published var favorites: [String] = []

    var favoritesPublisher: AnyPublisher<[String], Never> {
        $favorites.eraseToAnyPublisher()
    }


    init() {
        logger.debug("Created InMemoryFavoritesService")
    }

    func has(message: String) -> Bool {
        favorites.contains(message)
    }

    func addFavorite(message: String) -> Bool {
        favorites.append(message)
        logger.debug("Added \(message)")
        return true
    }

    func removeFavorite(message: String) -> Bool {
        favorites.removeAll(where: { $0 == message })
        logger.debug("Removed \(message)")
        return false
    }
}
