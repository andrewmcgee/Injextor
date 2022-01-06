//
//  Optional+Extensions.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import Foundation

extension Optional: AnyOptional {
    
    /// The type that is wrapped by the `Optional` as `Any.Type`, which can then be type casted as required.
    var wrappedType: Any.Type {
        Wrapped.self
    }
}
