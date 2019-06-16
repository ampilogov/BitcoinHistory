//
//  PriceDetailInteractor.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol PriceDetailInteractorProtocol {
    func retrieveDetailPrice()
}

class PriceDetailInteractor: PriceDetailInteractorProtocol, PriceUpdateListener {

    weak var presenter: PriceDetailPresenterProtocol?
    private let priceSevice: IPriceService
    private let priceRefresher: IPriceRefresher
    private let date: String
    
    init(date: String, priceSevice: IPriceService, priceRefresher: IPriceRefresher) {
        self.date = date
        self.priceSevice = priceSevice
        self.priceRefresher = priceRefresher
        priceRefresher.add(listener: self)
    }
    
    // MARK: - PriceDetailInteractorProtocol
    
    func retrieveDetailPrice() {

        let isToday = DateFormatter.yyyyMMdd.string(from: Date()) == date
        
        if isToday {
            // load current price for today
            priceSevice.loadCurrentPrice(completion: { [weak self] result in
                self?.handleResult(result)
            })
        } else {
            // load history date for previous days
            priceSevice.loadPriceDetails(at: date, completion: { [weak self] result in
                self?.handleResult(result)
            })
        }
    }
    
    private func handleResult(_ result: Result<Price, Error>) {
        switch result {
        case .success(let price): presenter?.didRetrivePrice(price)
        case .failure(let error): presenter?.didGetError(error)
        }
    }
    
    // MARK: - PriceDetailInteractorProtocol
    
    func didUpdateRate(with price: Price) {
        presenter?.didRetrivePrice(price)
    }
}
