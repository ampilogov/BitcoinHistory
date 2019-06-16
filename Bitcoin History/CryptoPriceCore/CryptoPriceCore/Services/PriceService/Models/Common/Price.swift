//
//  Price.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public struct Price: Decodable, Equatable {
    public let EUR: Amount
    public let USD: Amount
    public let GBP: Amount
}
