//
//  BitcoinPriceRequest.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import NetworkCore

class BitcoinPriceRequest: BaseRequest<BitcoinPriceResponse> {
    
    override var baseUrl: String {
        return "https://api.coindesk.com/v1/"
    }
    
    override var service: String {
        return "bpi/currentprice.json"
    }
}
