//
//  UtilsTests.swift
//  UtilsTests
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
@testable import Utils

class UtilsTests: XCTestCase {

    func testDateFormatter() {
        
        // Given
        let dateFormatter = DateFormatter.yyyyMMdd
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // When
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: 0))
        
        // Then
        XCTAssertEqual(date, "1970-01-01")
    }
    
    func testNumberFormatter() {
        
        // Given
        let numberFormatter = NumberFormatter.currency
        numberFormatter.locale = Locale(identifier: "en_US")
        
        // When
        let number = numberFormatter.string(from: NSNumber(value: 12.24))
        
        // Then
        XCTAssertEqual(number, "$12.24")
    }
    
    func testDIContainer() {
        
        // Given
        let object = MockObject(value: 5)
        
        
        // When
        DIContainer.main.register(key: MockObject.self, instance: object)
        
        // Then
        XCTAssertEqual(DIContainer.main.get(MockObject.self).value, 5)
    }
}

class MockObject {
    let value: Int
    init(value: Int) {
        self.value = value
    }
}
