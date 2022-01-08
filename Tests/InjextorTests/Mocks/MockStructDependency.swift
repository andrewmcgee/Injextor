//
//  MockStructDependency.swift
//  Injextor
//
//  Created by Andrew McGee on 08/01/2022.
//

import Foundation
@testable import Injextor

class MockStructDependency: MockMutableDependencyType {
    let uuid: UUID = UUID()
    var mutableValue: Int = 0
}
