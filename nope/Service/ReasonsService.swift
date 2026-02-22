//
//  ReasonsService.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import Foundation
import Combine

final class ReasonsService: ObservableObject {

    private let logger = AutoLogger.unifiedLogger()

    @Published var reasons: [String] = []

    init() {
        if let reasons: [String] = loadJSON("reasons") {
            self.reasons = reasons
        }
    }

    func loadJSON<T: Decodable>(_ filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            logger.error("❌ \(filename).json not found")
            return nil
        }


        do {
            let data = try Data(contentsOf: url)
            let reasons = try JSONDecoder().decode(T.self, from: data)
            return reasons
        } catch {
            print("❌ Failed to decode reasons:", error)
            return nil
        }
    }
}
