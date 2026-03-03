//
//  FavoritesViewModelTests.swift
//  nope
//
//  Created by Sushant Verma on 3/3/2026.
//

import Testing
@testable import nope
import Foundation

struct FavoritesViewModelTests {

    var resolver: DependencyResolver

    var viewModel: FavoritesViewModel

    init() {
        self.resolver = DependencyResolver.forPreview()
        self.viewModel = FavoritesViewModel(resolver)
    }

    @Test func hasNoFavorites() async throws {
        let favoritesService: FavoritesService = await resolver.resolve()

        #expect(favoritesService.favorites.isEmpty)
        #expect(viewModel.favorites.isEmpty)
    }

    @Test func updatesWhenFavoritesChange() async throws {
        let favoritesService: FavoritesService = await resolver.resolve()
        await favoritesService.addFavorite(message: #function)

        #expect(favoritesService.favorites.count == 1)
        #expect(viewModel.favorites.count == 1)
    }

    @Test func initiallyNothingIsCopied() async throws {
        #expect(viewModel.copied == nil)
    }

    @Test func hasExpectedCopyMessageDuration() async throws {
        #expect(viewModel.copyMessageDuration == Duration.seconds(2))
    }

    @Test func copiesContent() async throws {
        let testName = #function

        await viewModel.copy(reason: testName)
        #expect(viewModel.copied == testName)
    }

    @Test func copiedContentClearsAfterDopyDelay() async throws {
        let favoritesService: FavoritesService = await resolver.resolve()
        await favoritesService.addFavorite(message: "a")
        await favoritesService.addFavorite(message: "b")
        await favoritesService.addFavorite(message: "c")

        #expect(viewModel.favorites.count == 3)

        await viewModel.delete(at: IndexSet([1]))//delete 'b'

        #expect(viewModel.favorites.count == 2)
    }

    @Test func deletesContent() async throws {
        let testName = #function
        let testWait = Duration.milliseconds(10)
        await MainActor.run {
            viewModel.copyMessageDuration = testWait
        }

        await viewModel.copy(reason: testName)
        #expect(viewModel.copied == testName)
        try await Task.sleep(for: testWait + .milliseconds(10))
        #expect(viewModel.copied == nil)
    }
}
