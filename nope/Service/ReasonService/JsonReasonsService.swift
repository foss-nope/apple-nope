//
//  JsonReasonsService.swift
//  nope
//
//  Created by Sushant Verma on 4/3/2026.
//

import UtilityKit
import Foundation

class JsonReasonsService: ReasonsService {

    private lazy var jsonService: JSONResourceService<[String]> = {
        JSONResourceService<[String]>(BundleResource("reasons.json"))
    }()

    var reasons: [String] { jsonService.content ?? [] }
}
