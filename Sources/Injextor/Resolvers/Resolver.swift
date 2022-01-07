//
//  Resolver.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// An implementation of `ResolverType` which handles regular, non-singleton dependencies. New instances will be returned each time they are resolved.
public class Resolver: ResolverType {
    
    /// Stores a `Dictionary` of dependency builders where the `Key`s are `ObjectIdentifier` values of the metatype assoicated with the dependency.
    private var builders = [ObjectIdentifier: () -> Any]()
    
    /// Registers a type for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    public func register<T>(_ builder: @escaping () -> T) {
        builders[ObjectIdentifier(T.self)] = builder
    }
    
    /// Resolves a type that has been previously registered with this `ResolverType`. In each case it will be a new instance.
    /// - Returns: A new instance of a type that has been previously registered with this `ResolverType`. In each case it will be a new instance.
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
