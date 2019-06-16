//
//  PriceListViewMock.swift
//  Bitcoin HistoryTests
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
@testable import Bitcoin_History

class PriceListViewMock: PriceListViewProtocol {
    
    var alert: String?
    var items = [PriceModel]()
    
    func reload(with prices: [PriceModel]) {
        items = prices
    }
    
    func hideLoader() {
        
    }
    
    func showAlert(_ text: String) {
        alert = text
    }
}
