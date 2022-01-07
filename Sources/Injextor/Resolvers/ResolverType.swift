//
//  ResolverType.swift
//  Injextor
//
//  Created by Andrew McGee on 2/1/2022.
//

import Foundation

/// Defines types that are responsible for registering and resolving dependencies.
public protocol ResolverType {
    
    /// Registers a type for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    func register<T>(_ builder: @escaping () -> T)
    
    /// Resolves a type that has been previously registered with this `ResolverType`.
    func resolve<T>() -> T
    
    /// Removes all stored dependencies.
    func removeAll()
}
