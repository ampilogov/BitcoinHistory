//
//  PriceListWireframe.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import PriceCore
import Utils

protocol PriceListWireframeProtocol {
    func openPriceDetail(for date: String)
}

class PriceListWireframe: PriceListWireframeProtocol {
    
    weak var transitionHandler: UIViewController?
    
    static func createPriceListModule() -> UIViewController {
        let priceService = DIContainer.main.get(IPriceService.self)
        let priceRefresher = DIContainer.main.get(IPriceRefresher.self)
        let interactor = PriceListInteractor(priceSevice: priceService, priceRefresher: priceRefresher)
        let wireframe = PriceListWireframe()
        let presenter = PriceListPresenter(interactor: interactor, wireframe: wireframe)
        let view = PriceListView(presenter: presenter)
        
        presenter.view = view
        wireframe.transitionHandler = view
        interactor.presenter = presenter
        
        return view
    }
    
    func openPriceDetail(for date: String) {
        let viewController = PriceDetailWireframe.createPriceDetalModule(with: date)
        transitionHandler?.navigationController?.pushViewController(viewController, animated: true)
    }
}
