//
//  DefaultsFavoritesService.swift
//  nope
//
//  Created by Sushant Verma on 26/2/2026.
//

import Foundation
import Combine

class DefaultsFavoritesService: InMemoryFavoritesService {

    private let logger = AutoLogger.unifiedLogger()

    private var cancellables: Set<AnyCancellable> = []

    override init() {
        super.init()

        favorites = readFavorites()

        $favorites
            .sink {[weak self] updated in
                self?.write(updated)
            }.store(in: &cancellables)
    }

    private func readFavorites() -> [String] {
        logger.debug("Reading favorites from UserDefaults")

        return UserDefaults.standard.stringArray(forKey: "DefaultsFavoritesService.favorites") ?? []
    }

    func write(_ updated: [String]) {
        logger.debug("Writing favorites to UserDefaults")
        
        UserDefaults.standard.set(updated, forKey: "DefaultsFavoritesService.favorites")
    }
}
