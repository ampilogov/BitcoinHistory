//
//  PriceListInteractor.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol PriceListInteractorProtocol {
    func retrievePriceHisrory()
    func retrieveCurrentPrice()
}

class PriceListInteractor: PriceListInteractorProtocol, PriceUpdateListener {
    
    weak var presenter: PriceListPresenterProtocol?
    private let priceSevice: IPriceService
    private let priceRefresher: IPriceRefresher
    private let historyLenght = 14
    private let refreshInterval = 60.0
    
    init(priceSevice: IPriceService, priceRefresher: IPriceRefresher) {
        self.priceSevice = priceSevice
        self.priceRefresher = priceRefresher
        priceRefresher.add(listener: self)
        priceRefresher.startRefreshingCurrentRate(interval: refreshInterval)
    }
    
    // MARK: - PriceListInteractorProtocol
    
    func retrievePriceHisrory() {
        
        let group = DispatchGroup()
        
        // Get history for previous days
        var history = [PriceHistoryItem]()
        group.enter()
        priceSevice.loadHistory(daysBefore: historyLenght, completion: { [weak self] result in
            switch result {
            case .success(let items): history = items
            case .failure(let error): self?.presenter?.didGetError(error)
            }
            group.leave()
        })
        
        // Get current day price
        var currentPrice: Price?
        group.enter()
        priceSevice.loadCurrentPrice(completion: { [weak self] result in
            switch result {
            case .success(let price): currentPrice = price
            case .failure(let error): self?.presenter?.didGetError(error)
            }
            group.leave()
        })
        
        // Merge history prices and current day price
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            guard let price = currentPrice else {
                self.presenter?.didGetError(NSError.default)
                return
            }
            
            let prices = history + [self.todayHistoryItem(from: price)]
            self.presenter?.didRetrivePrices(prices.reversed())
        }
    }
    
    func retrieveCurrentPrice() {
        priceSevice.loadCurrentPrice(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detailPrice):
                let item = self.todayHistoryItem(from: detailPrice)
                self.presenter?.didRetriveCurrentPrice(item)
            case .failure(let error): self.presenter?.didGetError(error)
            }
        })
    }
    
    // MARK: - PriceUpdateListener
    
    func didUpdateRate(with price: Price) {
        let historyItem = todayHistoryItem(from: price)
        presenter?.didRetriveCurrentPrice(historyItem)
    }
    
    // MARK: - Private
    
    private func todayHistoryItem(from price: Price) -> PriceHistoryItem {
        let date = DateFormatter.yyyyMMdd.string(from: Date())
        return PriceHistoryItem(date: date, value: price.EUR.value)
    }
}
