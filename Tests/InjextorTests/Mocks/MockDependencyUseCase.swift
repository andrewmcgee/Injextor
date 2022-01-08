//
//  MockDependencyUseCase.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation
@testable import Injextor

class MockDependencyUseCase {
    
    @Dependency var mockUniqueDependency: MockDependencyType
    @SingletonDependency var mockSingletonDependency: Singleton<MockDependencyType>
    
    init(uniqueDependency: DependencyOverride<MockDependencyType> = .none,
         singletonDependency: SingletonOverride<MockDependencyType> = .none) {
        $mockUniqueDependency.override(with: uniqueDependency)
        $mockSingletonDependency.override(with: singletonDependency)
    }
}
