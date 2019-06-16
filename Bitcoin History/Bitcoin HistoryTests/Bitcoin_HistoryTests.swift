//
//  Bitcoin_HistoryTests.swift
//  Bitcoin HistoryTests
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import XCTest
import PriceCore
@testable import Bitcoin_History

class Bitcoin_HistoryTests: XCTestCase {
    
    func testLoadHistoryOnStart() {
        
        // Given
        let interactor = PriceListInteractorMock()
        let presenter = PriceListPresenter(interactor: interactor,
                                           wireframe: PriceListWireframe())
        
        // When
        presenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactor.didCallPriceHisrory)
    }
    
    func testHandleError() {
        
        // Given
        let interactor = PriceListInteractorMock()
        let view = PriceListViewMock()
        let presenter = PriceListPresenter(interactor: interactor,
                                           wireframe: PriceListWireframe())
        presenter.view = view
        
        
        // When
        presenter.didGetError(NSError.default)
        
        // Then
        XCTAssertEqual(view.alert, NSError.default.localizedDescription)
    }
    
    func testUpdateCurrentRate() {
        
        // Given
        let interactor = PriceListInteractorMock()
        let view = PriceListViewMock()
        let currentDate = "2019-06-10"
        let presenter = PriceListPresenter(interactor: interactor,
                                           wireframe: PriceListWireframe())
        presenter.view = view
        
        
        // When
        presenter.didRetrivePrices([PriceHistoryItem(date: "2019-01-01", value: 120.0)])
        presenter.didRetriveCurrentPrice(PriceHistoryItem(date: currentDate, value: 450.0))
        
        // Then
        let exp = expectation(description: "Test after 2 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(view.items[0].date, currentDate)
        } else {
            XCTFail("Delay interrupted")
        }
        
    }
}
