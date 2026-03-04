//
//  AboutView.swift
//  nope
//
//  Created by Sushant Verma on 4/3/2026.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) private var openURL

    private let inspirationURL = URL(string: "https://github.com/hotheadhacker/no-as-a-service")!
    private let sourceURL = URL(string: "https://github.com/foss-nope/apple-nope")!

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nope")
                        .font(.title2.bold())

                    Text("A simple app designed to help you say no with confidence.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 6)
            }

            Section("Inspiration") {
                Button {
                    openURL(inspirationURL)
                } label: {
                    Label("No as a Service (HotHeadHacker)", systemImage: "sparkles")
                }

                Text("Inspired by the wonderfully absurd “No as a Service” project.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section("Open Source") {
                Button {
                    openURL(sourceURL)
                } label: {
                    Label("View Nope App source on GitHub", systemImage: "chevron.left.slash.chevron.right")
                }

                Text("Feel free to explore the code, suggest improvements, or contribute.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section("Special Thanks") {
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("App Icon")
                            .font(.body.weight(.semibold))
                        Text("Special thanks to Anik Verma for his contributions in creating the psychedelic app icon.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 2)

                Image(.anikArt)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .contextMenu {
                        Button {
                            UIPasteboard.general.image = UIImage.anikArt
                        } label: {
                            Label("Copy Image", systemImage: "doc.on.doc")
                        }

                        ShareLink(
                            item: Image(.anikArt),
                            preview: SharePreview("Anik Verma Art", image: Image(.anikArt))
                        )
                    }
                    .draggable(Image(.anikArt))
                }
        }
        .tabItem {
            Label("About", systemImage: "questionmark.text.page")
        }
    }
}

#Preview {
    TabView {
        AboutView()
    }

}
