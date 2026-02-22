//
//  RandomReasonView.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import SwiftUI

struct RandomReasonView: View {
    var resolver: DependencyResolver

    @StateObject var viewModel: RandomReasonViewModel

    init(_ resolver: DependencyResolver) {
        self.resolver = resolver
        _viewModel = .init(wrappedValue: .init(resolver))
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 50) {
                    Text(viewModel.reason)
                        .font(Font.largeTitle.bold())
                        .textSelection(.enabled)
                    HStack {
                        Spacer()

                        Button(action: viewModel.copyReason) {
                            Label(
                                viewModel.copied ? "Copied" : "Copy",
                                systemImage: viewModel.copied ? "checkmark" : "doc.on.doc"
                            )
                            .font(.system(size: 17))           // fix size to prevent any glyph height variance
                            .imageScale(.medium)               // consistent icon sizing
                            .foregroundStyle(viewModel.copied ? .green : .primary)
                            .contentTransition(.opacity)       // ← this enables cross-fade on text & symbol change
                            .animation(.default, value: viewModel.copied)  // or .easeInOut(duration: 0.3), etc.
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(minHeight: geo.size.height)   // 👈 fills viewport
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: viewModel.reason) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleFavourite()
                } label: {
                    Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.loadNewReason()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .refreshable {
            viewModel.loadNewReason()
        }
    }
}

#Preview {
    TabView {
        RandomReasonTabContent(.forPreview())
    }
}
