//
//  TodayInteractor.swift
//  Bitcoin History Widget
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol TodayInteractorProtocol {
    func retriveAmount()
}

class TodayInteractor: TodayInteractorProtocol, PriceUpdateListener {

    weak var presenter: TodayPresenterProtocol?
    private let priceService: IPriceService
    private let refresher: IPriceRefresher
    private let reloadInterval = 10.0
    
    init(priceService: IPriceService, refresher: IPriceRefresher) {
        self.priceService = priceService
        self.refresher = refresher
        refresher.startRefreshingCurrentRate(interval: reloadInterval)
        refresher.add(listener: self)
    }
    
    func retriveAmount() {
        priceService.loadCurrentPrice(completion: { [weak self] result in
            guard let amount = try? result.get().EUR else { return }
            self?.presenter?.didRetriveAmount(amount)
        })
    }
    
    func didUpdateRate(with price: Price) {
        presenter?.didRetriveAmount(price.EUR)
    }
    
}
