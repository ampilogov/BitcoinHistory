//
//  PriceServicesRegistrator.swift
//  CryptoPriceCore
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import Utils
import NetworkCore

public class PriceServicesRegistrator {
    public class func register() {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let networkService = NetworkService(session: session)
        let priceService = PriceService(networkService: networkService)
        DIContainer.main.register(key: IPriceService.self, instance: priceService)
        
        let refresher = PriceRefresher(priceService: priceService)
        DIContainer.main.register(key: IPriceRefresher.self, instance: refresher)
    }
}
