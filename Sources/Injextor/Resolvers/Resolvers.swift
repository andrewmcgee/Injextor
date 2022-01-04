//
//  Resolvers.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Class intended to be used as a singleton to store default `ResolverType` values: one for unique dependencies and the other for singletons.
/// These can be overridden, but existing dependencies will remain unchanged (including singletons). However new dependencies will be created
/// using the new `ResolverType`s and thus create new instances (including singletons) from thereon.
public class Resolvers {

    /// Holds a singleton instance of `Resolvers`.
    public static let shared = Resolvers()

    /// Holds a default instance of `ResolverType` used to resolve unique dependencies.
    public var unique: ResolverType = Resolver()
    
    /// Holds a default instance of `ResolverType` used to resolve singleton dependencies.
    public var singletons: ResolverType = SingletonResolver()
    
    /// Makes the `init` private.
    private init() {}
    
    /// Removes all stored dependencies from all resolvers.
    public func removeAll() {
        unique.removeAll()
        singletons.removeAll()
    }
}
