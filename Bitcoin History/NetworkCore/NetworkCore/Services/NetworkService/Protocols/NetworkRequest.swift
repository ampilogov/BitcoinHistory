//
//  NetworkRequest.swift
//  NetworkCore
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public protocol NetworkRequest {
    
    // Result model
    associatedtype Model: Decodable
    
    // URL request construcrtor
    func constructURLRequest() -> URLRequest
}
