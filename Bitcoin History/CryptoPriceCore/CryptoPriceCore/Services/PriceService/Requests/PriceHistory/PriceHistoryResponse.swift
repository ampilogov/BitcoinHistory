//
//  PriceHistoryResponse.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

struct PriceHistoryResponse {
    
    let history: [PriceHistoryItem]
    
    enum CodingKeys: String, CodingKey {
        case bpi
    }
}

extension PriceHistoryResponse: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let historyDict = try container.decode([String: Double].self, forKey: .bpi)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let items = historyDict.enumerated().map({ PriceHistoryItem(date: $0.element.key, value: $0.element.value) })
        history = items.sorted(by: { $0.date < $1.date })
    }
}

public struct PriceHistoryItem: Equatable {
    
    public init(date: String, value: Double) {
        self.date = date
        self.value = value
    }
    
    public let date: String
    public let value: Double
}
