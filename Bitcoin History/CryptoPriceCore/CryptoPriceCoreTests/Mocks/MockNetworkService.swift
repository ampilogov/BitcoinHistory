//
//  MockNetworkService.swift
//  PriceCoreTests
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import NetworkCore

class MockNetworkService: INetworkService {
    
    var result: Any?
    
    func load<T>(_ request: T, completion: @escaping (Result<T.Model, Error>) -> Void) -> Cancelable where T : NetworkRequest {
        
        let model = result as! T.Model
        completion(.success(model))

        return URLSessionDataTask()
    }
}
