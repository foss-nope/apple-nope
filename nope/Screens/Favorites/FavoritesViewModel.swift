//
//  FavoritesViewModel.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import Combine
import SwiftUI

class FavoritesViewModel: ObservableObject {

    private let logger = AutoLogger.unifiedLogger()

    private var favoritesService: FavoritesService

    @Published var favorites: [String] = []
    @Published var copied: String? = nil

    init(_ resolver: DependencyResolver) {
        favoritesService = resolver.resolve()

        favoritesService.favoritesPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$favorites)
    }

    func onAppear() {
        logger.trace("On appear")
        favorites = favoritesService.favorites
    }

    func copy(reason: String) {
        UIPasteboard.general.string = reason
        copied = reason

        Task {
            await resetCopiedAfterDelay()
        }
    }

    @MainActor
    func resetCopiedAfterDelay() async {
        try? await Task.sleep(for: .seconds(2))
        copied = nil
    }

    func delete(at offsets: IndexSet) {
        logger.trace("Delete: \(offsets)")

        offsets
            .map { self.favorites[$0] }
            .forEach { favoritesService.removeFavorite(message: $0) }

        // Refresh local cache from the service
        favorites = favoritesService.favorites
    }
}

