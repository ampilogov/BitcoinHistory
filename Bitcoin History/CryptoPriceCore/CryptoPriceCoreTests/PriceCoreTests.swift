//
//  CryptoPriceCoreTests.swift
//  CryptoPriceCoreTests
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
@testable import PriceCore

class CryptoPriceCoreTests: XCTestCase {

    func testPriceRefresher() {
        
        // Given
        let priceService = MockPriceService()
        let refresher = PriceRefresher(priceService: priceService)
        
        // When
        refresher.startRefreshingCurrentRate(interval: 1.0)
        
        // Then
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(priceService.curentPriceCallCount, 5)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testLoadCurrentPrice() {
        // Given
        let amount = Amount(code: "XXX", value: 100)
        let price = Price(EUR: amount, USD: amount, GBP: amount)
        let networkService = MockNetworkService()
        networkService.result = BitcoinPriceResponse(bpi: price)
        let priceService = PriceService(networkService: networkService)
        
        // When
        priceService.loadCurrentPrice { result in
            let value = try! result.get()
            
            // Then
            XCTAssert(value == price)
        }
    }
    
    func testLoadHistory() {
        
        // Given
        let item = PriceHistoryItem(date: "2019-06-10", value: 100.0)
        let networkService = MockNetworkService()
        networkService.result = PriceHistoryResponse(history: [item])
        let priceService = PriceService(networkService: networkService)
        
        // When
        priceService.loadHistory(daysBefore: 1, completion: { result in
            let value = try! result.get()
            // Then
            XCTAssert(value == [item])
        })
    }
}
