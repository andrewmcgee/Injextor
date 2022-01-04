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
    
    /// Hold an instance of the dependency.
    private var value: T

    /// Initializes an instance of a `Dependency` using the given `ResolverType`. If none is provided then the default unique resolver is used.
    /// - Parameter resolver: A `ResolverType` usef to resolve the dependency. If none is provided then the default unique resolver is used.
    public init(resolver: ResolverType = Resolvers.shared.unique) {
        value = resolver.resolve()
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public var wrappedValue: T {
        get { value }
    }
}
