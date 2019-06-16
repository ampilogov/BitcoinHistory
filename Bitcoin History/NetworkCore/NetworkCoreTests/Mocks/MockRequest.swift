//
//  MockRequest.swift
//  NetworkCoreTests
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
@testable import NetworkCore

class MockRequest: BaseRequest<String> {
    
    override var method: String {
        return "POST"
    }
    
    override var baseUrl: String {
        return "https://example.com/"
    }
    
    override var service: String {
        return "callback"
    }
    
    override var parameters: [String: String] {
        return ["parameter1": "1"]
    }
    
    override var headers: [String: String] {
        return ["h1": "1", "h2": "2"]
    }
    
    override var httpBody: Data? {
        return Data(base64Encoded: "1100110")
    }
}
