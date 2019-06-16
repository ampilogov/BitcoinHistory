//
//  Amount.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import Utils

public struct Amount: Decodable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case value = "rate_float"
    }
    
    public let code: String
    public let value: Double

    public var symbol: String {
        return Currency(rawValue: code)?.symbol ?? ""
    }
}
