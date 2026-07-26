//
//  RandomReasonViewModel.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import Combine
import SwiftUI
import SwiftDependencyInjection

class RandomReasonViewModel: ObservableObject {

    private let reasonsService: ReasonsService
    private let favoritesService: FavoritesService
    private var pasteboard: UIPasteboard

    private let logger = AutoLogger.unifiedLogger()

    @Published var reason: String = ""
    @Published var isFavourite: Bool = false
    @Published var copied: Bool = false

    var copyMessageDuration = Duration.seconds(2)

    init(reasonsService: ReasonsService,
         favoritesService: FavoritesService,
         pasteboard: UIPasteboard
    ) {
        self.reasonsService = reasonsService
        self.favoritesService = favoritesService
        self.pasteboard = pasteboard

        loadNewReason()
    }

    convenience init(_ resolver: DependencyContainer) {
        self.init(
            reasonsService: resolver.resolveRequired(),
            favoritesService: resolver.resolveRequired(),
            pasteboard: resolver.resolveRequired()
        )
    }

    func onAppear() {
        logger.trace("On appear")
        isFavourite = favoritesService.has(message: reason)
    }

    func copyReason() {
        pasteboard.string = reason
        copied = true

        Task {
            await resetCopiedMessageAfterDelay()
        }
    }

    @MainActor
    func resetCopiedMessageAfterDelay() async {
        try? await Task.sleep(for: copyMessageDuration)
        copied = false
    }

    func loadNewReason() {
        logger.info("Finding a new reason")

        // Keep trying to fetch a new reason till we have a new one.
        var newReason = reasonsService.reasons.randomElement()
        var reasonRegen = 0
        while newReason == reason && reasonRegen < 10 {
            reasonRegen += 1
            newReason = reasonsService.reasons.randomElement()
        }
        reason = newReason ?? "No reason available"
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

