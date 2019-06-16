//
//  PriceService.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import NetworkCore
import Utils

public protocol IPriceService {
    
    // Load current price
    func loadCurrentPrice(completion: @escaping (Result<Price, Error>) -> Void)
    
    // Load prices hisnory for N days
    func loadHistory(daysBefore: Int, completion: @escaping (Result<[PriceHistoryItem], Error>) -> Void)
    
    // Load USD, EUR, GBP prices at specific date
    func loadPriceDetails(at date: String, completion: @escaping (Result<Price, Error>) -> Void)
}

class PriceService: IPriceService {

    private let networkService: INetworkService
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func loadCurrentPrice(completion: @escaping (Result<Price, Error>) -> Void) {
        let request = BitcoinPriceRequest()
        networkService.load(request, completion: { completion($0.map({ $0.bpi })) })
    }
    
    func loadHistory(daysBefore: Int, completion: @escaping (Result<[PriceHistoryItem], Error>) -> Void) {
        guard let startDate = Calendar.current.date(byAdding: .day, value: -daysBefore, to: Date()) else {
            completion(.failure(NSError.default))
            return
        }
        
        let start = DateFormatter.yyyyMMdd.string(from: startDate)
        let end = DateFormatter.yyyyMMdd.string(from: Date())
        
        let request = PriceHistoryRequest(currency: .EUR, startDate: start, endDate: end)
        networkService.load(request, completion: { completion($0.map({ $0.history })) })
    }
    
    func loadPriceDetails(at date: String, completion: @escaping (Result<Price, Error>) -> Void) {
        
        let group = DispatchGroup()
        var results = [Currency: Amount]()
        let currencies = Currency.all
        
        // Send requests for each currency
        for currency in currencies {
            group.enter()
            let request = PriceHistoryRequest(currency: currency, startDate: date, endDate: date)
            networkService.load(request, completion: { (response) in
                if let value = try? response.get().history.first?.value {
                    let amount = Amount(code: currency.rawValue, value: value)
                    results[currency] = amount
                }
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            if let eurResult = results[.EUR], let usdResult = results[.USD], let gbpResult = results[.GBP] {
                let price = Price(EUR: eurResult, USD: usdResult, GBP: gbpResult)
                completion(.success(price))
            } else {
                completion(.failure(NSError.default))
            }
        }
    }
}
