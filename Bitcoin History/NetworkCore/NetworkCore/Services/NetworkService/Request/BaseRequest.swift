//
//  BaseRequest.swift
//  Network
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

open class BaseRequest<T: Decodable>: NetworkRequest {
    public typealias Model = T
    
    public init() { }
    
    open var method: String {
        return "GET"
    }
    
    open var baseUrl: String {
        return ""
    }
    
    open var service: String {
        return ""
    }
    
    open var parameters: [String: String] {
        return [:]
    }
    
    open var headers: [String: String] {
        return [:]
    }
    
    open var httpBody: Data? {
        return nil
    }
    
    open func constructURLString() -> String {
        var urlString = baseUrl + service
        if !parameters.isEmpty {
            let urlParameters = parameters.enumerated()
                .map({ $0.element.key + "=" + $0.element.value })
                .joined(separator: "&")
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            
            if let urlParameters = urlParameters {
                urlString += "?" + urlParameters
            }
        }
        
        return urlString
    }
    
    public func constructURLRequest() -> URLRequest {
        let urlString = constructURLString()
        let url = URL(string: urlString) ?? URL(fileURLWithPath: urlString)
        var request = URLRequest(url: url)
        request.httpMethod = method
        headers.forEach({ request.setValue($0.value, forHTTPHeaderField: $0.key) })
        request.httpBody = httpBody
        return request
    }
}
