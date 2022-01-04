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
    
    /// Initializes an instance of `Lazy` with the given `wrappedValue` (provided as an autoclosure). Closures should not be provided. Use `init(builder:)` instead.
    /// - Parameter wrappedValue: A type (provided as an autoclosure) which is not initialized until it is first accessed.
    init(wrappedValue: @autoclosure @escaping () -> T) {
        self = .uninitialized(wrappedValue)
    }
    
    /// Initializes an instance of `Lazy` with the given builder closure. The return value of the closure will become the `wrappedValue`.
    /// - Parameter wrappedValue: A closure returning the `wrappedValue` which is not called until the `wrappedValue` it is first accessed.
    init(builder: @escaping () -> T) {
        self = .uninitialized(builder)
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
