//
//  Resolvers.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// Class intended to be used as a singleton to store default `ResolverType` values: one for unique dependencies and the other for singletons. These can be overridden.
public class Resolvers {

    /// Holds a singleton instance of `Resolvers`.
    public static let shared = Resolvers()

    /// Makes the `init` private.
    private init() {}
    
    /// Holds a default instance of `ResolverType` used to resolve unique dependencies.
    var unique: ResolverType = Resolver()
    
    /// Holds a default instance of `ResolverType` used to resolve singleton dependencies.
    var _singletons: ResolverType = SingletonResolver()
}
