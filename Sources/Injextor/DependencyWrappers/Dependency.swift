//
//  Dependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Property wrapper to hold a unique depdency.
@propertyWrapper
public struct Dependency<T> {
    
    /// Stores the resolver to be used to resolve the dependency.
    private let resolver: ResolverType
    
    /// Hold an instance of the dependency. Lazy so it is not resolved until it is first used. If it is set to a custom value before it is resolved, then it will never be resolved.
    private lazy var value: T = {
        resolver.resolve()
    }()

    /// Initializes an instance of a `Dependency` using the given `ResolverType`. If none is provided then the default unique resolver is used.
    /// - Parameter resolver: A `ResolverType` used to resolve the dependency. If none is provided then the default unique resolver is used.
    public init(resolver: ResolverType = Resolvers.shared.unique) {
        self.resolver = resolver
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public var wrappedValue: T {
        mutating get { value }
        set { value = newValue }
    }
}
