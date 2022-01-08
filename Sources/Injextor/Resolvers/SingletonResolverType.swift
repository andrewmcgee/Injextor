//
//  SingletonResolverType.swift
//  Injextor
//
//  Created by Andrew McGee on 2/1/2022.
//

import Foundation

/// Defines types that are responsible for registering and resolving dependencies.
public protocol SingletonResolverType {
    
    /// Registers a dependency, wrapped in a closure for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    func register<T>(_ builder: @escaping () -> T)
    
    /// Resolves a dependency that has been previously registered with this resolver. In each case it will be the same `Singleton` instance.
    /// - Returns: A `Singleton` instance of a type that has been previously registered with this resolver.
    func resolve<T>() -> Singleton<T>
    
    /// Removes all stored dependencies.
    func removeAll()
}
