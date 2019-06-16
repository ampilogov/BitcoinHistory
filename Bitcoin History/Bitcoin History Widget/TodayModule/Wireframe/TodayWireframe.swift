//
//  TodayWireframe.swift
//  Bitcoin History Widget
//
//  Created by Vitaliy Ampilogov on 6/16/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

class TodayWireframe {
    
    static func createTodayModule() -> UIViewController {

        let priceService = DIContainer.main.get(IPriceService.self)
        let refresher = DIContainer.main.get(IPriceRefresher.self)
        
        let interactor = TodayInteractor(priceService: priceService, refresher: refresher)
        let presenter = TodayPresenter(interactor: interactor)
        let view = TodayView(presenter: presenter)
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
