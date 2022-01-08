//
//  MockDependencyUseCaseWithAlternativeResolvers.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import Foundation
@testable import Injextor

class MockDependencyUseCaseWithAlternativeResolvers {
    
    static let uniqueResolver = UniqueResolver()
    static let singletionResolver = SingletonResolver()
    
    @Dependency(resolver: MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver) var mockUniqueDependency: MockDependencyType
    @SingletonDependency(resolver: MockDependencyUseCaseWithAlternativeResolvers.singletionResolver) var mockSingletonDependency: Singleton<MockDependencyType>
}
