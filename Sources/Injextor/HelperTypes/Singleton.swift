//
//  Singleton.swift
//  Injextor
//
//  Created by Andrew McGee on 08/01/2022.
//

import Foundation

/// A class wrapper for singletons so they can be both reference and value types.
public class Singleton<T> {
    
    /// The singleton wrapped value.
    var value: T
    
    /// Initializes a Singleton for the given wrapped value.
    /// - Parameter value: The singleton value to wrap.
    init(value: T) {
        self.value = value
    }
}
