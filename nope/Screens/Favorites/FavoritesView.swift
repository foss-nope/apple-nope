//
//  FavoritesView.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import SwiftUI

struct FavoritesView: View {
    var resolver: DependencyResolver

    @StateObject var viewModel: FavoritesViewModel

    init(_ resolver: DependencyResolver) {
        self.resolver = resolver
        _viewModel = .init(wrappedValue: .init(resolver))
    }

    var body: some View {
        NavigationStack {
            bodyContent
        }
        .tabItem {
            Label("Favorites", systemImage: "heart")
        }
        .badge(viewModel.favorites.count)
    }

    @ViewBuilder
    private var bodyContent: some View {
        if viewModel.favorites.isEmpty {
            emptyView
        } else {
            listOfFavorites
        }
    }

    private var emptyView: some View {
        ContentUnavailableView("No favorites yet.",
                               systemImage: "heart.slash",
                               description: Text("Add some to get started!"))
    }

    private var listOfFavorites: some View {
        List {
            ForEach(viewModel.favorites, id: \.self) { item in
                Text(item)
                    .foregroundStyle(viewModel.copied == item ? .green : .primary)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        // Copy to clipboard action
                        Button {
                            viewModel.copy(reason: item)
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        .labelStyle(.iconOnly)
                        .tint(.green)

                        // Share action (using ShareLink for native share sheet)
                        ShareLink(item: item) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .labelStyle(.iconOnly)
                    }
            }
            .onDelete(perform: viewModel.delete)
        }
        .toolbar { EditButton() } // optional: enables multi-delete / reordering UI
    }
}

#Preview {
    TabView {
        FavoritesView(.forPreview())
    }
}
