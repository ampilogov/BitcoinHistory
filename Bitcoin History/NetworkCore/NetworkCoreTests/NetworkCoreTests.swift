//
//  NetworkCoreTests.swift
//  NetworkCoreTests
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
@testable import NetworkCore

class NetworkCoreTests: XCTestCase {

    func testBaseRequestContructURL() {
        // Given
        let request = MockRequest()
        
        // When
        let url = request.constructURLString()
        
        // Then
        XCTAssertEqual(url, "https://example.com/callback?parameter1=1")
    }
    
    func testBaseRequestParameters() {
        // Given
        let request = MockRequest()
        
        // When
        let urlRequest = request.constructURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/callback?parameter1=1")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["h1": "1", "h2": "2"])
        XCTAssertEqual(urlRequest.httpBody, Data(base64Encoded: "1100110"))
    }
    
    func testSessionRequest() {
        // Given
        let request = MockRequest()
        let urlRequest = request.constructURLRequest()
        let session = MockSession()
        let networkService = NetworkService(session: session)
        
        // When
        _ = networkService.load(request) { _ in }
        
        // Then
        XCTAssertEqual(urlRequest, session.request)
    }
}
