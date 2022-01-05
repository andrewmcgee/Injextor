//
//  MockOptionalDependencyUseCase.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import Foundation
@testable import Injextor

class MockOptionalDependencyUseCase {
    
    @Dependency var mockUniqueDependency: MockDependencyType?
    @SingletonDependency var mockSingletonDependency: MockDependencyType?
    
    init(uniqueDependency: DependencyOverride<MockDependencyType?> = .none,
         singletonDependency: DependencyOverride<MockDependencyType?> = .none) {
        $mockUniqueDependency.override(with: uniqueDependency)
        $mockSingletonDependency.override(with: singletonDependency)
    }
}
