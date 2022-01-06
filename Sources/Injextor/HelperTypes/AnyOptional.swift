//
//  AnyOptional.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import Foundation

/// A protocol designed to be adopted by `Optional`, so `Optional` values can be grouped and identified more generically, and have shared functionality added.
protocol AnyOptional {
    
    /// The type that is wrapped by the `Optional` as `Any.Type`, which can then be type casted as required.
    var wrappedType: Any.Type { get }
}
