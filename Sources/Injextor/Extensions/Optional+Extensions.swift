//
//  Optional+Extensions.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import Foundation

extension Optional: AnyOptional {
    
    /// A method to return the type that is wrapped by the `Optional` as `Any.Type`, which can then be type casted as required.
    /// - Returns: The type that is wrapped by the `Optional` as `Any.Type`, which can then be type casted as required.
    func wrappedType() -> Any.Type {
        return Wrapped.self
    }
}
