//
//  Dependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Property wrapper to hold a unique dependency.
@propertyWrapper
public class Dependency<T> {
    
    /// Stores the resolver to be used to resolve the dependency.
    let resolver: UniqueResolverType
    
    /// Hold an instance of the dependency. Lazy so it is not resolved until it is first used.
    /// If it is set to a custom value before it is resolved, then it will never be resolved.
    lazy var value: T = {
        resolver.resolve()
    }()

    /// Initializes an instance of a `Dependency` using the given `UniqueResolverType`. If none is provided then the default unique resolver is used.
    /// - Parameter resolver: A `UniqueResolverType` used to resolve the dependency. If none is provided then the default unique resolver is used.
    public init(resolver: UniqueResolverType = Resolvers.shared.unique) {
        self.resolver = resolver
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public var wrappedValue: T {
        get { value }
        set { value = newValue }
    }

    /// Provides access to this property wrapper's projected value of type `Dependency<T>`, so additional methods can be accessed.
    public var projectedValue: Dependency<T> {
        get { self }
    }
    
    /// Overrides the value of the dependency with a custom override value. If the case of the `DependencyOverride` is `.none`, then no override takes place.
    /// - Parameter override: The `DependencyOverride` to use for the potential override.
    public func override(with override: DependencyOverride<T>) {
        if case let .value(value) = override {
            self.value = value
        }
    }
}
