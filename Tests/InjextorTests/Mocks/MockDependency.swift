//
//  MockDependency.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation
@testable import Injextor

class MockDependency: MockDependencyType {
    let uuid: UUID = UUID()
}
