//
//  RandomReasonTabContent.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import SwiftUI
import SwiftDependencyInjection

struct RandomReasonTabContent: View {
    private var resolver: DependencyContainer

    init(_ resolver: DependencyContainer) {
        self.resolver = resolver
    }

    var body: some View {
        NavigationStack {
            RandomReasonView(resolver)
        }
        .tabItem {
            Label("Random Reason", systemImage: "dice")
        }
    }
}

#Preview {
    TabView {
        RandomReasonTabContent(.forPreview())
    }
}
