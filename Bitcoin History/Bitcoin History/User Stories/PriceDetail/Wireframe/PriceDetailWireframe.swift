//
//  PriceDetailWireframe.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import PriceCore
import Utils

class PriceDetailWireframe {
    
    static func createPriceDetalModule(with date: String) -> UIViewController {
        let priceService = DIContainer.main.get(IPriceService.self)
        let priceRefresher = DIContainer.main.get(IPriceRefresher.self)
        let interactor = PriceDetailInteractor(date: date, priceSevice: priceService, priceRefresher: priceRefresher)
        let presenter = PriceDetailPresenter(interactor: interactor)
        let view = PriceDetailView(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
