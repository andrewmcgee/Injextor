//
//  LazyTests.swift
//  Injextor
//
//  Created by Andrew McGee on 04/01/2022.
//

import XCTest
@testable import Injextor

class LazyTests: XCTestCase {

    func testLazyBuilderInitializer() {
        var lazy = Lazy(builder: { String("string") })
        
        guard case .uninitialized = lazy else {
            XCTFail()
            return
        }
        
        _ = lazy.wrappedValue
        
        guard case let .initialized(value) = lazy else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(value, "string")
    }
    
    func testLazyWrappedValueInitializer() {
        var lazy = Lazy(wrappedValue: String("string"))
        
        guard case .uninitialized = lazy else {
            XCTFail()
            return
        }
        
        _ = lazy.wrappedValue
        
        guard case let .initialized(value) = lazy else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(value, "string")
    }
}
