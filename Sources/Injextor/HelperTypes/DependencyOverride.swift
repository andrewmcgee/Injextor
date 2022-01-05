//
//  DependencyOverride.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import Foundation

/// A generic enum to specify if a dependency should be overridden and also wrap the value to use for the override.
public enum DependencyOverride<T> {
    
    /// The dependency should not be overridden.
    case none
    
    /// The dependency sould be overridden with the associated value.
    case value(T)
}
