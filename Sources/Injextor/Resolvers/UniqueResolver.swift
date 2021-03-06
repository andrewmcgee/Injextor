//
//  UniqueResolver.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// An implementation of `ResolverType` which handles regular, non-singleton dependencies. New instances will be returned each time they are resolved.
public class UniqueResolver: UniqueResolverType {
    
    /// Stores a `Dictionary` of dependency builders where the `Key`s are `ObjectIdentifier` values of the metatype assoicated with the dependency.
    private var builders = [ObjectIdentifier: () -> Any]()
    
    /// Registers a dependency wrapped in a closure for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    ///  - returns: A `@discardableResult` of `Self` to enable functional chaining of this method.
    @discardableResult public func register<T>(_ builder: @escaping () -> T) -> Self {
        builders[ObjectIdentifier(T.self)] = builder
        return self
    }
    
    /// Resolves a dependency that has been previously registered with this resolver. In each case it will be a new instance.
    /// - Returns: A new instance of a dependency that has been previously registered with this resolver. In each case it will be a new instance.
    public func resolve<T>() -> T {
        guard let value = builders[ObjectIdentifier(T.self)]?() as? T else {
            fatalError("\(T.self) has not been registered with this resolver.")
        }
        return value
    }
    
    /// Removes all stored dependency builders.
    public func removeAll() {
        builders.removeAll()
    }
}
