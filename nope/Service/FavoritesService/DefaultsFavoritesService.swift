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

    let defaultsSuiteName = "favorites.defaults"
    let defaultsKey = "DefaultsFavoritesService.favorites"

    private lazy var defaults: UserDefaults = {
        if let suite = UserDefaults(suiteName: defaultsSuiteName) {
            return suite
        } else {
            logger.error("Unable to create UserDefaults suite '\(self.defaultsSuiteName)'.")
            fatalError("Unable to create UserDefaults suite '\(self.defaultsSuiteName)'.")
        }
    }()

    override init() {
        super.init()
        logger.debug("Created DefaultsFavoritesService: InMemoryFavoritesService")

        favorites = readFavorites()

        $favorites
            .sink {[weak self] updated in
                self?.write(updated)
            }.store(in: &cancellables)
    }

    private func readFavorites() -> [String] {
        logger.debug("Reading \(self.defaultsKey) from UserDefaults(\(self.defaultsSuiteName))")

        return defaults.stringArray(forKey: defaultsKey) ?? []
    }

    func write(_ updated: [String]) {
        logger.debug("Writing \(self.defaultsKey) to UserDefaults(\(self.defaultsSuiteName))")

        defaults.set(updated, forKey: defaultsKey)
    }
}
