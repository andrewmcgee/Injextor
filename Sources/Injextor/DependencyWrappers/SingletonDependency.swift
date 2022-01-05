//
//  SingletonDependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Property wrapper to hold a singleton class depdency. Registering non-class types with throw a fatal error.
@propertyWrapper
public struct SingletonDependency<T> {
    
    /// Stores the resolver to be used to resolve the dependency.
    private let resolver: ResolverType
    
    /// Hold an instance of the singleton dependency. Lazy so it is not resolved until it is first used. If it is set to a custom value before it is resolved, then it will never be resolved.
    private lazy var value: T = {
        resolver.resolve()
    }()

    /// Initializes an instance of a `Dependency` using the given `ResolverType`. If none is provided then the default singleton resolver is used.
    /// - Parameter resolver: A `ResolverType` used to resolve the dependency. If none is provided then the default singleton resolver is used.
    public init(resolver: ResolverType = Resolvers.shared.singletons) {
        self.resolver = resolver
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public var wrappedValue: T {
        mutating get { value }
        set { value = newValue }
    }
    
    /// Provides access to this property wrapper's projected value of type `Self`, so additional methods can be accessed.
    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    /// Overrides the `value` property with a custom value. If `nil` is passed then no override takes place.
    /// - Parameter value: The value to use for the override.
    public mutating func override(with value: T?) {
        if let value = value {
            self.value = value
        }
    }
}
