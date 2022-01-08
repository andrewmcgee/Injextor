//
//  MockMutableDependencyUseCase.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation
@testable import Injextor

class MockMutableDependencyUseCase {
    
    @Dependency var mockUniqueDependency: MockMutableDependencyType
    @SingletonDependency var mockSingletonDependency: Singleton<MockMutableDependencyType>
    
    init(uniqueDependency: DependencyOverride<MockMutableDependencyType> = .none,
         singletonDependency: SingletonOverride<MockMutableDependencyType> = .none) {
        $mockUniqueDependency.override(with: uniqueDependency)
        $mockSingletonDependency.override(with: singletonDependency)
    }
}
