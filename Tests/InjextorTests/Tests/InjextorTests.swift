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
    
    func testUniqueDependenciesCanBeOverridden() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        anotherMock.mockUniqueDependency = mock.mockUniqueDependency
        XCTAssertEqual(mock.mockUniqueDependency.uuid, anotherMock.mockUniqueDependency.uuid)
    }
    
    func testUniqueDependenciesCanBeOverriddenViaInitialization() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(uniqueDependency: .value(mock.mockUniqueDependency))
        XCTAssertEqual(mock.mockUniqueDependency.uuid, anotherMock.mockUniqueDependency.uuid)
    }
    
    func testUniqueDependenciesNotOverriddenViaInitializationWhenNoneCasePassed() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(uniqueDependency: .none)
        XCTAssertNotEqual(mock.mockUniqueDependency.uuid, anotherMock.mockUniqueDependency.uuid)
    }
    
    func testOptionalUniqueDependenciesAreDifferent() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase()
        let mockUniqueDependency = try XCTUnwrap(mock.mockUniqueDependency)
        let anotherMockUniqueDependency = try XCTUnwrap(anotherMock.mockUniqueDependency)
        XCTAssertNotEqual(mockUniqueDependency.uuid, anotherMockUniqueDependency.uuid)
    }
    
    func testOptionalUniqueDependenciesCanBeOverridenToNil() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase()
        anotherMock.mockUniqueDependency = nil
        let mockUniqueDependency = try XCTUnwrap(mock.mockUniqueDependency)
        XCTAssertNil(anotherMock.mockUniqueDependency)
        XCTAssertNotEqual(mockUniqueDependency.uuid, anotherMock.mockUniqueDependency?.uuid)
    }
    
    func testOptionalUniqueDependenciesCanBeOverridenToNilViaInitialization() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase(uniqueDependency: .value(nil))
        let mockUniqueDependency = try XCTUnwrap(mock.mockUniqueDependency)
        XCTAssertNil(anotherMock.mockUniqueDependency)
        XCTAssertNotEqual(mockUniqueDependency.uuid, anotherMock.mockUniqueDependency?.uuid)
    }
    
    func testOptionalUniqueDependenciesNotOverriddenViaInitializationWhenNoneCasePassed() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase(uniqueDependency: .none)
        let mockUniqueDependency = try XCTUnwrap(mock.mockUniqueDependency)
        let anotherMockUniqueDependency = try XCTUnwrap(anotherMock.mockUniqueDependency)
        XCTAssertNotEqual(mockUniqueDependency.uuid, anotherMockUniqueDependency.uuid)
    }
    
    func testSingletonDependenciesAreTheSame() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
    }
    
    func testSingletonDependenciesCanBeOverridden() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        anotherMock.mockSingletonDependency = MockDependency()
        XCTAssertNotEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
    }
    
    func testSingletonDependenciesCanBeOverriddenViaInitialization() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(singletonDependency: .value(MockDependency()))
        XCTAssertNotEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
    }
    
    func testSingletonDependenciesNotOverriddenViaInitializationWhenNoneCasePassed() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(singletonDependency: .none)
        XCTAssertEqual(mock.mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.uuid)
    }
    
    func testOptionalSingletonDependenciesAreDifferent() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase()
        let mockSingletonDependency = try XCTUnwrap(mock.mockUniqueDependency)
        let anotherMockSingletonDependency = try XCTUnwrap(anotherMock.mockUniqueDependency)
        XCTAssertNotEqual(mockSingletonDependency.uuid, anotherMockSingletonDependency.uuid)
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
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register { newDependency as MockDependencyType }
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register { newDependency as MockDependencyType }
        let mock = MockDependencyUseCase()
        let alternativeMock = MockDependencyUseCaseWithAlternativeResolvers()
        XCTAssertNotEqual(mock.mockSingletonDependency.uuid, alternativeMock.mockSingletonDependency.uuid)
    }
    
    func testAlternativeResolversResolveSameUniqueDependenciesWhenSameAreRegistered() {
        let mock = MockDependencyUseCase()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register { mock.mockUniqueDependency as MockDependencyType }
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register { mock.mockSingletonDependency as MockDependencyType }
        let alternativeMock = MockDependencyUseCaseWithAlternativeResolvers()
        XCTAssertEqual(mock.mockUniqueDependency.uuid, alternativeMock.mockUniqueDependency.uuid)
    }
    
    func testOptionalUniqueDependenciesCanBeRegisteredAsNil() throws {
        removeAllDependencies()
        Resolvers.shared.unique.register { nil as MockDependencyType? }
        let mock = MockOptionalDependencyUseCase()
        XCTAssertNil(mock.mockUniqueDependency)
    }
    
    func testOptionalUniqueDependenciesRegisteredAsNilCanBeOverriddenToNotNil() throws {
        removeAllDependencies()
        Resolvers.shared.unique.register { nil as MockDependencyType? }
        let mock = MockOptionalDependencyUseCase()
        XCTAssertNil(mock.mockUniqueDependency)
        mock.mockUniqueDependency = MockDependency()
        XCTAssertNotNil(mock.mockUniqueDependency)
    }
    
    private func registerDependencies() {
        Resolvers.shared.unique.register { MockDependency() as MockDependencyType }
        Resolvers.shared.singletons.register { MockDependency() as MockDependencyType }
        Resolvers.shared.unique.register { MockDependency() as MockDependencyType? }
        Resolvers.shared.singletons.register { MockDependency() as MockDependencyType? }
    }
    
    private func removeAllDependencies() {
        Resolvers.shared.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.removeAll()
    }
}
