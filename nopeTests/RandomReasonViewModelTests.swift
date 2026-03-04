//
//  RandomReasonViewModelTests.swift
//  nope
//
//  Created by Sushant Verma on 4/3/2026.
//

import Testing
import Foundation

@testable import nope

struct RandomReasonViewModelTests {

    var resolver: DependencyResolver

    var stubReasonsService: StubReasonsService

    var viewModel: RandomReasonViewModel

    init() {
        let stubReasonsService = StubReasonsService([
            "Reason 1",
            "Reason 2"
        ])
        self.resolver = DependencyResolver.forPreview()
        resolver.register(ReasonsService.self, resolved: .singleton) { _ in
            stubReasonsService
        }
        self.stubReasonsService = stubReasonsService
        self.viewModel = RandomReasonViewModel(resolver)
    }

    @Test func initialState() async throws {
        #expect(viewModel.reason.isEmpty == false)
        #expect(viewModel.isFavourite == false)
    }

    @Test func copyAction() async throws {
        let pasteboard: PasteboardWriting = await resolver.resolve()

        #expect(viewModel.copied == false)
        #expect(pasteboard.string == nil)
        await viewModel.copyReason()
        #expect(viewModel.copied == true)
        #expect(pasteboard.string != nil)
    }

    @Test func copyActionAutoResets() async throws {
        let testWait = Duration.milliseconds(10)
        await MainActor.run {
            viewModel.copyMessageDuration = testWait
        }

        let pasteboard: PasteboardWriting = await resolver.resolve()

        #expect(viewModel.copyMessageDuration == .milliseconds(10))

        await viewModel.copyReason()
        #expect(viewModel.copied == true)
        #expect(pasteboard.string != nil)

        try await Task.sleep(for: testWait + .milliseconds(10))
        #expect(viewModel.copied == false)
    }

    @Test func loadNewReason_changesReason() async throws {
        let reason = await viewModel.reason
        await viewModel.loadNewReason()
        #expect(viewModel.reason != reason)
    }

    @Test func loadNewReason_givesUp() async throws {
        let originalReason = await viewModel.reason
        await MainActor.run {
            stubReasonsService.reasons = [originalReason]
        }

        await viewModel.loadNewReason()
        #expect(viewModel.reason == originalReason)
    }

    @Test func toggleFavourite_toggles() async throws {
        #expect(viewModel.reason != "No reason available")
        #expect(viewModel.isFavourite == false)

        await viewModel.toggleFavourite()
        #expect(viewModel.isFavourite == true)

        await viewModel.toggleFavourite()
        #expect(viewModel.isFavourite == false)
    }
}
