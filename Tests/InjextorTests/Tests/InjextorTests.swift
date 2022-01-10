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
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testSingletonDependenciesAreTheSameWhenValueTypes() {
        removeAllDependencies()
        Resolvers.shared.singletons.register { MockStructDependency() as MockDependencyType }
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testSingletonDependenciesAreMutableWhenValueTypes() {
        removeAllDependencies()
        Resolvers.shared.singletons.register { MockStructDependency() as MockMutableDependencyType }
        let mock = MockMutableDependencyUseCase()
        let anotherMock = MockMutableDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
        XCTAssertEqual(mock.mockSingletonDependency.value.mutableValue, 0)
        XCTAssertEqual(anotherMock.mockSingletonDependency.value.mutableValue, 0)
        mock.mockSingletonDependency.value.mutableValue = 1
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
        XCTAssertEqual(mock.mockSingletonDependency.value.mutableValue, 1)
        XCTAssertEqual(anotherMock.mockSingletonDependency.value.mutableValue, 1)
    }
    
    func testSingletonDependenciesCanBeOverridden() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        anotherMock.mockSingletonDependency = Singleton(value: MockDependency())
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testSingletonDependenciesCanBeOverriddenWhenValueTypes() {
        removeAllDependencies()
        Resolvers.shared.singletons.register { MockStructDependency() as MockDependencyType }
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        anotherMock.mockSingletonDependency = Singleton(value: MockStructDependency())
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testOptionalSingletonDependenciesCanBeOverridenToNil() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase()
        anotherMock.mockSingletonDependency = Singleton(value: nil)
        let mockSingletonDependency = try XCTUnwrap(mock.mockSingletonDependency.value)
        XCTAssertNil(anotherMock.mockSingletonDependency.value)
        XCTAssertNotEqual(mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.value?.uuid)
    }
    
    func testSingletonDependenciesCanBeOverriddenViaInitialization() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(singletonDependency: .value(Singleton(value: MockDependency())))
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testSingletonDependenciesCanBeOverriddenViaInitializationWhenValueTypes() {
        removeAllDependencies()
        Resolvers.shared.singletons.register { MockStructDependency() as MockDependencyType }
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(singletonDependency: .value(Singleton(value: MockStructDependency())))
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testOptionalSingletonDependenciesCanBeOverridenToNilViaInitialization() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase(singletonDependency: .value(.init(value: nil)))
        let mockSingletonDependency = try XCTUnwrap(mock.mockSingletonDependency.value)
        XCTAssertNil(anotherMock.mockSingletonDependency.value)
        XCTAssertNotEqual(mockSingletonDependency.uuid, anotherMock.mockSingletonDependency.value?.uuid)
    }
    
    func testSingletonDependenciesNotOverriddenViaInitializationWhenNoneCasePassed() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase(singletonDependency: .none)
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
    }
    
    func testOptionalSingletonDependenciesNotOverriddenViaInitializationWhenNoneCasePassed() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase(singletonDependency: .none)
        let mockSingletonDependency = try XCTUnwrap(mock.mockSingletonDependency.value)
        let anotherMockSingletonDependency = try XCTUnwrap(anotherMock.mockSingletonDependency.value)
        XCTAssertEqual(mockSingletonDependency.uuid, anotherMockSingletonDependency.uuid)
    }
    
    func testOptionalSingletonDependenciesAreTheSame() throws {
        let mock = MockOptionalDependencyUseCase()
        let anotherMock = MockOptionalDependencyUseCase()
        let mockSingletonDependency = try XCTUnwrap(mock.mockSingletonDependency.value)
        let anotherMockSingletonDependency = try XCTUnwrap(anotherMock.mockSingletonDependency.value)
        XCTAssertEqual(mockSingletonDependency.uuid, anotherMockSingletonDependency.uuid)
    }
    
    func testOptionalSingletonDependenciesAreMutableWhenValueTypes() {
        removeAllDependencies()
        Resolvers.shared.singletons.register { MockStructDependency() as MockMutableDependencyType? }
        let mock = MockOptionalMutableDependencyUseCase()
        let anotherMock = MockOptionalMutableDependencyUseCase()
        XCTAssertNotNil(mock.mockSingletonDependency.value)
        XCTAssertEqual(mock.mockSingletonDependency.value?.uuid, anotherMock.mockSingletonDependency.value?.uuid)
        XCTAssertEqual(mock.mockSingletonDependency.value?.mutableValue, 0)
        XCTAssertEqual(anotherMock.mockSingletonDependency.value?.mutableValue, 0)
        mock.mockSingletonDependency.value?.mutableValue = 1
        XCTAssertNotNil(mock.mockSingletonDependency.value)
        XCTAssertEqual(mock.mockSingletonDependency.value?.uuid, anotherMock.mockSingletonDependency.value?.uuid)
        XCTAssertEqual(mock.mockSingletonDependency.value?.mutableValue, 1)
        XCTAssertEqual(anotherMock.mockSingletonDependency.value?.mutableValue, 1)
    }
    
    func testSingletonDependenciesAreDifferentAfterAllDependenciesRemovedFromResolvers() {
        let mock = MockDependencyUseCase()
        let anotherMock = MockDependencyUseCase()
        XCTAssertEqual(mock.mockSingletonDependency.value.uuid, anotherMock.mockSingletonDependency.value.uuid)
        removeAllDependencies()
        registerDependencies()
        let aThirdMock = MockDependencyUseCase()
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, aThirdMock.mockSingletonDependency.value.uuid)
    }
    
    func testAlternativeResolversResolveDifferentSingletonDependencies() {
        let newDependency = MockDependency()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register { newDependency as MockDependencyType }
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register { newDependency as MockDependencyType }
        let mock = MockDependencyUseCase()
        let alternativeMock = MockDependencyUseCaseWithAlternativeResolvers()
        XCTAssertNotEqual(mock.mockSingletonDependency.value.uuid, alternativeMock.mockSingletonDependency.value.uuid)
    }
    
    func testAlternativeResolversResolveSameUniqueDependenciesWhenSameAreRegistered() {
        let mock = MockDependencyUseCase()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.register { mock.mockUniqueDependency as MockDependencyType }
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.register { mock.mockSingletonDependency.value as MockDependencyType }
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
    
    func testOptionalSingletonDependenciesCanBeRegisteredAsNil() throws {
        removeAllDependencies()
        Resolvers.shared.singletons.register { nil as MockDependencyType? }
        let mock = MockOptionalDependencyUseCase()
        XCTAssertNil(mock.mockSingletonDependency.value)
    }
    
    func testOptionalSingletonDependenciesRegisteredAsNilCanBeOverriddenToNotNil() throws {
        removeAllDependencies()
        Resolvers.shared.singletons.register { nil as MockDependencyType? }
        let mock = MockOptionalDependencyUseCase()
        XCTAssertNil(mock.mockSingletonDependency.value)
        mock.mockSingletonDependency = Singleton(value: MockDependency())
        XCTAssertNotNil(mock.mockSingletonDependency.value)
    }
    
    private func registerDependencies() {
        Resolvers.shared.unique
            .register { MockDependency() as MockDependencyType }
            .register { MockDependency() as MockDependencyType? }
        Resolvers.shared.singletons
            .register { MockDependency() as MockDependencyType }
            .register { MockDependency() as MockDependencyType? }
    }
    
    private func removeAllDependencies() {
        Resolvers.shared.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.uniqueResolver.removeAll()
        MockDependencyUseCaseWithAlternativeResolvers.singletionResolver.removeAll()
    }
}
