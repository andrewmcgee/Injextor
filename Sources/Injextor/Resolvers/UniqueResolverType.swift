//
//  UniqueResolverType.swift
//  Injextor
//
//  Created by Andrew McGee on 2/1/2022.
//

import Foundation

/// Defines types that are responsible for registering and resolving dependencies.
public protocol UniqueResolverType {
    
    /// Registers a dependency wrapped in a closure for dependency injection with this resolver.
    ///  - parameter builder: A closure used to build a dependency.
    ///  - returns: A `@discardableResult` of `Self` to enable functional chaining of this method.
    @discardableResult func register<T>(_ builder: @escaping () -> T) -> Self
    
    /// Resolves a dependency that has been previously registered with this resolver. In each case it will be a new instance.
    /// - Returns: A new instance of a dependency that has been previously registered with this resolver. In each case it will be a new instance.
    func resolve<T>() -> T
    
    /// Removes all stored dependency builders.
    func removeAll()
}
