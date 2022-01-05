//
//  SingletonDependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Property wrapper to hold a singleton class depdency. Registering non-class types will throw a fatal error (except Optional class types).
@propertyWrapper
class SingletonDependency<T>: Dependency<T> {
  
    /// Initializes an instance of a `Dependency` using the given `ResolverType`. If none is provided then the default singleton resolver is used.
    /// - Parameter resolver: A `ResolverType` used to resolve the dependency. If none is provided then the default singleton resolver is used.
    public override init(resolver: ResolverType = Resolvers.shared.singletons) {
        super.init(resolver: resolver)
    }
    
    /// Provides the dependency as the property wrapper's wrapped value.
    public override var wrappedValue: T {
        get { value }
        set { value = newValue }
    }
    
    /// Provides access to this property wrapper's projected value of type `Self`, so additional methods can be accessed.
    public override var projectedValue: Dependency<T> {
        get { self }
    }
}
