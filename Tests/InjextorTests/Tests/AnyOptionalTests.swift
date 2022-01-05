//
//  AnyOptionalTests.swift
//  Injextor
//
//  Created by Andrew McGee on 05/01/2022.
//

import XCTest
@testable import Injextor

class AnyOptionalTests: XCTestCase {

    func testWrappedTypeWhenValueIsNotNil() {
        let int: Int? = 1
        XCTAssert(int.wrappedType() is Int.Type)
        XCTAssertFalse(int.wrappedType() is String.Type)
    }
    
    func testWrappedTypeWhenValueIsNil() {
        let int: Int? = nil
        XCTAssert(int.wrappedType() is Int.Type)
        XCTAssertFalse(int.wrappedType() is String.Type)
    }
}
