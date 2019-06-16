//
//  MockSession.swift
//  NetworkCoreTests
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
@testable import NetworkCore

class MockSession: URLSession {
    
    var request: URLRequest?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() { }
}
