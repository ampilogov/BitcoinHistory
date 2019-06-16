//
//  PriceListInteractorMock.swift
//  Bitcoin HistoryTests
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
@testable import Bitcoin_History

class PriceListInteractorMock: PriceListInteractorProtocol {
    
    var didCallPriceHisrory = false
    
    func retrievePriceHisrory() {
        didCallPriceHisrory = true
    }
    
    func retrieveCurrentPrice() {
        
    }
    
    
}
