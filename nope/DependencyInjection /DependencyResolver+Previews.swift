//
//  DependencyResolver+Previews.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

#if DEBUG
extension DependencyResolver {
    /// For SwiftUI Preview
    static func forPreview() -> DependencyResolver {
        let resolver = DependencyResolver.forApp()
        return resolver
    }
}
#endif
