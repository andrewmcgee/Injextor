//
//  MockMutableDependencyType.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation
@testable import Injextor

protocol MockMutableDependencyType: MockDependencyType {
    var mutableValue: Int { get set }
}
