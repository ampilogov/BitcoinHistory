//
//  Error.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

enum errorCode: Int {
    case network = -1
    case `default` = -2
}

public extension Error {
    
    static var network: Error {
        let userInfo = [NSLocalizedDescriptionKey: "Network error"]
        return NSError(domain: "network", code: errorCode.network.rawValue, userInfo: userInfo)
    }
    
    static var `default`: Error {
        let userInfo = [NSLocalizedDescriptionKey: "Error, please try again later"]
        return NSError(domain: "default", code: errorCode.network.rawValue, userInfo: userInfo)
    }
}
