//
//  MockPriceService.swift
//  PriceCore
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

@testable import PriceCore

class MockPriceService: IPriceService {
    
    var curentPriceCallCount = 0
    
    func loadCurrentPrice(completion: @escaping (Result<Price, Error>) -> Void) {
        curentPriceCallCount += 1
    }
    
    func loadHistory(daysBefore: Int, completion: @escaping (Result<[PriceHistoryItem], Error>) -> Void) {
        
    }
    
    func loadPriceDetails(at date: String, completion: @escaping (Result<Price, Error>) -> Void) {
        
    }
}
