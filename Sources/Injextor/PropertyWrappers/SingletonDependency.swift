//
//  SingletonDependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Property wrapper to hold a `Singleton` depdency.
@propertyWrapper
public class SingletonDependency<T> {
  
    /// Stores the `SingletonResolverType` to be used to resolve the dependency.
    let resolver: SingletonResolverType
    
    /// Hold an instance of the dependency. Lazy so it is not resolved until it is first used.
    /// If it is set to a custom value before it is resolved, then it will never be resolved.
    lazy var value: Singleton<T> = {
        resolver.resolve()
    }()

    /// Initializes an instance of a `SingletonDependency` using the given `SingletonResolverType`. If none is provided then the default singletons resolver is used.
    /// - Parameter resolver: A `SingletonResolverType` used to resolve the dependency. If none is provided then the default singletons resolver is used.
    public init(resolver: SingletonResolverType = Resolvers.shared.singletons) {
        self.resolver = resolver
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public var wrappedValue: Singleton<T> {
        get { value }
        set { value = newValue }
    }

    /// Provides access to this property wrapper's projected value of type `SingletonDependency<T>`, so additional methods can be accessed.
    public var projectedValue: SingletonDependency<T> {
        get { self }
    }
    
    /// Overrides the value of the dependency with a custom override value. If the case of the `SingletonOverride` is `.none`, then no override takes place.
    /// - Parameter override: The `SingletonOverride` to use for the potential override.
    public func override(with override: SingletonOverride<T>) {
        if case let .value(value) = override {
            self.value = value
        }
    }
}
