//
//  MockOptionalMutableDependencyUseCase.swift
//  Injextor
//
//  Created by Andrew McGee on 08/01/2022.
//

import Foundation
@testable import Injextor

class MockOptionalMutableDependencyUseCase {
    
    @Dependency var mockUniqueDependency: MockMutableDependencyType?
    @SingletonDependency var mockSingletonDependency: Singleton<MockMutableDependencyType?>
    
    init(uniqueDependency: DependencyOverride<MockMutableDependencyType?> = .none,
         singletonDependency: SingletonOverride<MockMutableDependencyType?> = .none) {
        $mockUniqueDependency.override(with: uniqueDependency)
        $mockSingletonDependency.override(with: singletonDependency)
    }
}
