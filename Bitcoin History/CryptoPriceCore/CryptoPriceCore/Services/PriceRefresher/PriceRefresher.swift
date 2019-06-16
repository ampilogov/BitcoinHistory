//
//  PriceRefresher.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import Utils

public protocol PriceUpdateListener {
    func didUpdateRate(with price: Price)
}

public protocol IPriceRefresher {
    
    // Start refresh current rate
    func startRefreshingCurrentRate(interval: TimeInterval)
    
    // Stop refresh current rate
    func stopRefreshingCurrentRate()
    
    // Add listener for rate updates
    func add(listener: PriceUpdateListener)
}

class PriceRefresher: IPriceRefresher {
    
    private let priceService: IPriceService
    private var listeners = WeakArray<PriceUpdateListener>()
    private var timer: Timer?
    
    init(priceService: IPriceService) {
        self.priceService = priceService
    }
    
    func startRefreshingCurrentRate(interval: TimeInterval) {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.priceService.loadCurrentPrice(completion: { result in
                switch result {
                case .success(let price): self.listeners.forEach({ $0.didUpdateRate(with: price) })
                case .failure(let error): print(error)
                }
            })
        }
    }
    
    func stopRefreshingCurrentRate() {
        timer?.invalidate()
        timer = nil
    }
    
    func add(listener: PriceUpdateListener) {
        listeners.add(listener)
    }
}
