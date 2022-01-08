//
//  SingletonOverride.swift
//  Injextor
//
//  Created by Andrew McGee on 08/01/2022.
//

import Foundation

/// A `typealias` that can be used as shorthand when the generic type of `DependencyOverride<T>` is a `Singleton<T>`.
public typealias SingletonOverride<T> = DependencyOverride<Singleton<T>>
