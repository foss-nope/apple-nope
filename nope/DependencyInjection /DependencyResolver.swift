//
//  DependencyResolver.swift
//  nope
//
//  Created by Sushant Verma on 17/2/2026.
//

import Swinject
import Combine

class DependencyResolver: ObservableObject {

    enum Resolution {
        /// Created once
        case singleton

        /// Reused until it is deallocated elsewhere
        case weak

        /// Created once per resolution cycle
        case perResolution

        var asSwinject: ObjectScope {
            switch self {
            case .singleton:
                return .container
            case .weak:
                return .weak
            case .perResolution:
                return .graph
            }
        }
    }

    private let swinjectContainer = Container()

    private init() {}

    internal static func createEmpty() -> DependencyResolver {
        .init()
    }

    func register<Component>(_ type: Component.Type,
                             resolved scope: Resolution,
                             _ factory: @escaping (DependencyResolver) -> Component) {
        swinjectContainer.register(type) { [weak self] _ in
            guard let self = self else { fatalError("Resolver has been deallocated") }
            return factory(self)
        }.inObjectScope(scope.asSwinject)
    }

    func resolve<Component>() -> Component {
        swinjectContainer.resolve(Component.self)! // ❗️Force unwrap
    }

    func resolve<Component>(_ type: Component.Type) -> Component {
        swinjectContainer.resolve(Component.self)! // ❗️Force unwrap
    }
}
