//
//  RandomReasonViewModel.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import Combine
import SwiftUI

class RandomReasonViewModel: ObservableObject {

    private let reasonsService: ReasonsService
    private let favoritesService: FavoritesService

    private let logger = AutoLogger.unifiedLogger()

    @Published var reason: String = ""
    @Published var isFavourite: Bool = false
    @Published var copied: Bool = false

    init(_ resolver: DependencyResolver) {
        reasonsService = resolver.resolve()
        favoritesService = resolver.resolve()

        loadNewReason()
    }

    func onAppear() {
        logger.trace("On appear")
        isFavourite = favoritesService.has(message: reason)
    }

    func copyReason() {
        UIPasteboard.general.string = reason
        copied = true

        Task {
            await resetCopiedAfterDelay()
        }
    }

    @MainActor
    func resetCopiedAfterDelay() async {
        try? await Task.sleep(for: .seconds(2))
        copied = false
    }

    func loadNewReason() {
        logger.info("Finding a new reason")
        reason = reasonsService.reasons.randomElement() ?? "No reason available"
        isFavourite = favoritesService.has(message: reason)
    }

    func toggleFavourite() {
        if isFavourite {
            isFavourite = favoritesService.removeFavorite(message: reason)
        } else {
            isFavourite = favoritesService.addFavorite(message: reason)
        }
    }
}

