//
//  SingletonResolver.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// An implementation of `SingletonResolverType` which handles singleton class dependencies. The same instance will be returned each time it is resolved.
public class SingletonResolver: SingletonResolverType {
    
    /// Stores a `Dictionary` of signleton dependencies, wrapped in `Lazy<Any>` values, where the `Key`s are `ObjectIdentifier` values of the metatype assoicated with the dependency.
    /// The wrapped value is lazy so it is not initialized until it is used the first time. Then it is stored here as a singleton.
    private var builders = [ObjectIdentifier: Lazy<Any>]()
    
    /// Registers a dependency, wrapped in a closure for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    ///  - returns: A `@discardableResult` of `Self` to enable functional chaining of this method.
    @discardableResult public func register<T>(_ builder: @escaping () -> T) -> Self {
        guard builders[ObjectIdentifier(T.self)] == nil else {
            fatalError("\(T.self) has already been registered with this singleton resolver.")
        }
        let singletonbuilder = {
            Singleton(value: builder())
        }
        builders[ObjectIdentifier(T.self)] = Lazy(builder: singletonbuilder)
        return self
    }
    
    /// Resolves a dependency that has been previously registered with this resolver. In each case it will be the same `Singleton` instance.
    /// - Returns: A `Singleton` instance of a type that has been previously registered with this resolver.
    public func resolve<T>() -> Singleton<T> {
        guard let value = builders[ObjectIdentifier(T.self)]?.wrappedValue as? Singleton<T> else {
            fatalError("\(T.self) has not been registered with this resolver.")
        }
        return value
    }
    
    /// Removes all stored dependencies.
    public func removeAll() {
        builders.removeAll()
    }
}
