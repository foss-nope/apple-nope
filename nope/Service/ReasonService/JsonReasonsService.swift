//
//  JsonReasonsService.swift
//  nope
//
//  Created by Sushant Verma on 4/3/2026.
//

import Foundation
import Combine

class JsonReasonsService: ReasonsService {
    private let logger = AutoLogger.unifiedLogger()

    var reasons: [String] = []

    init(resourceName: String) {
        if let reasons: [String] = loadJSON(resourceName) {
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
