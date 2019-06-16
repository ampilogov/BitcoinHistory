//
//  PriceHistoryRequest.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import NetworkCore
import Utils

class PriceHistoryRequest: BaseRequest<PriceHistoryResponse> {
    
    let currency: Currency
    let start: String
    let end: String
    
    init(currency: Currency, startDate: String, endDate: String) {
        self.currency = currency
        self.start = startDate
        self.end = endDate
    }
    
    override var baseUrl: String {
        return "https://api.coindesk.com/v1/"
    }
    
    override var service: String {
        return "bpi/historical/close.json"
    }
    
    override var parameters: [String: String] {
        return ["currency": currency.rawValue,
                "start": start,
                "end": end]
    }
}
