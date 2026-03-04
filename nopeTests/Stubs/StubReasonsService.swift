//
//  StubReasonsService.swift
//  nope
//
//  Created by Sushant Verma on 4/3/2026.
//

@testable import nope

class StubReasonsService: ReasonsService {
    var reasons: [String]

    init(_ reasons: [String]) {
        self.reasons = reasons
    }
}
