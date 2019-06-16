//
//  Currency.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public enum Currency: String {
    case EUR
    case USD
    case GBP
    
    public var symbol: String {
        switch self {
        case .EUR: return "€"
        case .USD: return "$"
        case .GBP: return "£"
        }
    }
    
    public static var all: [Currency] = [.EUR, .USD, .GBP]
}
