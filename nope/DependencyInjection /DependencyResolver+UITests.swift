//
//  DependencyResolver+UITests.swift
//  nope
//
//  Created by Sushant Verma on 23/2/2026.
//

#if DEBUG
extension DependencyResolver {
    /// For SwiftUI Preview
    static func forUITests() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        return resolver
    }
}
#endif
