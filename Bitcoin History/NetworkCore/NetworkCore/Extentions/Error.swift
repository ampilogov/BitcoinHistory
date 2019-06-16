//
//  Error.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import Utils

enum errorCode: Int {
    case network = -1
}

extension Error {
    
    static var network: Error {
        let userInfo = [NSLocalizedDescriptionKey: loc("error.network")]
        return NSError(domain: "network", code: errorCode.network.rawValue, userInfo: userInfo)
    }
}
