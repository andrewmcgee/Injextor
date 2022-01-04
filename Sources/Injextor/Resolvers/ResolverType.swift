//
//  ResolverType.swift
//  Injextor
//
//  Created by Andrew McGee on 2/1/2022.
//

import Foundation

/// Defines types that are responsible for registering and resolving dependencies.
public protocol ResolverType {
    
    /// Registers a type for dependency injection with this `ResolverType`.
    ///  - parameter builder: A closure (or type provided as an autoclosure) used to build a dependency.
    func register<T>(_ builder: @autoclosure @escaping () -> T)
    
    /// Resolves a type that has been previously registered with this `ResolverType`.
    func resolve<T>() -> T
    
    /// Removes all stored dependencies.
    func removeAll()
}
