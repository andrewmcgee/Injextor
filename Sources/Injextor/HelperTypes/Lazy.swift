//
//  Lazy.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation

/// A generic wrapper that delays the initialization of a `wrappedValue` until it is first accessed.
enum Lazy<T> {
    
    /// The state of `self` before the `wrappedValue` has been accessed.
    case uninitialized(() -> T)
    
    /// The state of `self` after the `wrappedValue` has been accessed and initialized.
    case initialized(T)
    
    
    /// Initializes an instance of `Lazy` with the given `wrappedValue`.
    /// - Parameter wrappedValue: An closure (or type provided as an autoclosure) which is not called or  initialized until it is first accessed.
    init(wrappedValue: @autoclosure @escaping () -> T) {
        self = .uninitialized(wrappedValue)
    }
    
    /// Provides access to a value that is not initialized until it is first accessed.
    var wrappedValue: T {
        mutating get {
            switch self {
            case .uninitialized(let builder):
                let value = builder()
                self = .initialized(value)
                return value
            case .initialized(let value):
                return value
            }
        }
    }
}
