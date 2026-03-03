//
//  InMemoryPasteboard.swift
//  nope
//
//  Created by Sushant Verma on 3/3/2026.
//


class InMemoryPasteboard: PasteboardWriting {
    var logger = AutoLogger.unifiedLogger()
    var string: String? = nil {
        didSet {
            if let value = string {
                logger.debug("Wrote to pasteboard: \(value)")
            } else {
                logger.debug("Deleted from pasteboard!")
            }
        }
    }
}

