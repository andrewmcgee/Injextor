//
//  InjextorTests.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import XCTest
@testable import Injextor

final class InjextorTests: XCTestCase {
        
    override func setUp() {
        registerDependencies()
    }
    
    override func tearDown() {
        removeAllDependencies()
    }
    
    func testRegisterDependencies() throws {
        let mock = MockDependencyUseCase()
        XCTAssertNotNil(mock)
    }
    
    func testUniqueDependenciesAreDifferent() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertNotEqual(mock.mockUniqueDependency.uuid, anotherMock.mockUniqueDependency.uuid)
    }
    
    func testSingletonDependenciesAreTheSame() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
    }
    
    func testSingletonDependenciesAreDifferentAfterAllDependenciesRemovedFromResolvers() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
        removeAllDependencies()
        registerDependencies()
        let aThirdMock = MockDependencyUseCase()
        XCTAssertNotEqual(mock.mockSingletonDependency.uuid, aThirdMock.mockSingletonDependency.uuid)
    }

    func testAlternativeResolversResolveDifferentSingletonDependencies() {
        let newDependency = MockDependency()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register(newDependency as MockDependencyType)
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register(newDependency as MockDependencyType)
        let mock = MockDependencyUseCase()
        let alternativeMock = MockDependencyUseCaseWithAlternativeResolvers()
        XCTAssertNotEqual(mock.mockSingletonDependency.uuid, alternativeMock.mockSingletonDependency.uuid)
    }
    
    func testAlternativeResolversResolveSameUniqueDependenciesWhenSameAreRegistered() {
        let mock = MockDependencyUseCase()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register(mock.mockUniqueDependency as MockDependencyType)
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register(mock.mockSingletonDependency as MockDependencyType)
        let alternativeMock = MockDependencyUseCaseWithAlternativeResolvers()
        XCTAssertEqual(mock.mockUniqueDependency.uuid, alternativeMock.mockUniqueDependency.uuid)
    }
    
    private func registerDependencies() {
        Resolvers.shared.unique.register(MockDependency() as MockDependencyType)
        Resolvers.shared.singletons.register(MockDependency() as MockDependencyType)
    }
    
    private func removeAllDependencies() {
        Resolvers.shared.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.removeAll()
    }
}
