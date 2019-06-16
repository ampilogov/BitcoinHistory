//
//  PriceDetailPresenter.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol PriceDetailPresenterProtocol: class {
    func viewDidLoad()
    func didRetrivePrice(_ price: Price)
    func didGetError(_ error: Error)
}

class PriceDetailPresenter: PriceDetailPresenterProtocol {

    weak var view: PriceDetailViewProtocol?
    private let interactor: PriceDetailInteractorProtocol
    
    init(interactor: PriceDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.retrieveDetailPrice()
    }
    
    func didRetrivePrice(_ price: Price) {
        let model = PriceDetailModel(eurValue: formatedValue(from: price.EUR),
                                     usdValue: formatedValue(from: price.USD),
                                     gbpValue: formatedValue(from: price.GBP))
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoader()
            self?.view?.reload(with: model)
        }
    }
    
    func didGetError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoader()
            self?.view?.showAlert(error.localizedDescription)
        }
    }
    
    // MARK: - Private
    
    private func formatedValue(from price: Amount) -> String {
        let formatter = NumberFormatter.currency
        formatter.currencySymbol = price.symbol
        
        return formatter.string(from: NSNumber(value: price.value)) ?? ""
    }
}
