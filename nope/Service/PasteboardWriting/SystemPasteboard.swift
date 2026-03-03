//
//  SystemPasteboard.swift
//  nope
//
//  Created by Sushant Verma on 3/3/2026.
//

import UIKit

struct SystemPasteboard: PasteboardWriting {
    var string: String? {
        get { UIPasteboard.general.string }
        set { UIPasteboard.general.string = newValue }
    }
}
