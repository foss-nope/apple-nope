//
//  AutoLogger.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//


@_exported import os.log
import Foundation

class AutoLogger {

    static func unifiedLogger(category: String = #function) -> os.Logger {
        os.Logger(subsystem: Bundle.main.bundleIdentifier!,
                  category: category)
    }
}
