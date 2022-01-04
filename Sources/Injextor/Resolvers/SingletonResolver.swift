//
//  SingletonResolver.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// An implementation of `ResolverType` which handles singleton class dependencies. The same instance will be returned each time it is resolved.
public class SingletonResolver: ResolverType {
    
    /// Stores a `Dictionary` of signleton dependencies, wrapped in `Lazy<Any>` values, where the `Key`s are `ObjectIdentifier` values of the metatype assoicated with the dependency.
    private var builders = [ObjectIdentifier: Lazy<Any>]()
    
    /// Registers a type for dependency injection with this `ResolverType`. Only class types are supported.
    ///  - parameter builder: A closure (or type provided as an autoclosure) used to build a new singleton instance of a dependency.
    public func register<T>(_ builder: @autoclosure @escaping () -> T) {
        guard builders[ObjectIdentifier(T.self)] == nil else {
            fatalError("\(T.self) has already been registered with this singleton resolver.")
        }
        builders[ObjectIdentifier(T.self)] = Lazy(builder: builder)
    }
    
    /// Resolves a type that has been previously registered with this `ResolverType`. In each case it will be the same singleton instance.
    /// - Returns: A singleton instance of a type that has been previously registered with this `ResolverType`.
    public func resolve<T>() -> T {
        guard let lazyValue = builders[ObjectIdentifier(T.self)]?.wrappedValue as? T else {
            fatalError("\(T.self) has not been registered with this resolver.")
        }
        guard type(of: lazyValue as Any) is AnyObject.Type else {
            fatalError("Only class types are supported by this SingletonResolver.")
        }
        return lazyValue
    }
}
