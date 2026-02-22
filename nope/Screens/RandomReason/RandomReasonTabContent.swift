//
//  RandomReasonTabContent.swift
//  nope
//
//  Created by Sushant Verma on 18/2/2026.
//

import SwiftUI

struct RandomReasonTabContent: View {
    var resolver: DependencyResolver

    init(_ resolver: DependencyResolver) {
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
