//
//  PriceListPresenter.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol PriceListPresenterProtocol: class {
    
    func viewDidLoad()
    func didSelectPrice(at indexPath: IndexPath)
    
    func didRetrivePrices(_ prices: [PriceHistoryItem])
    func didRetriveCurrentPrice(_ price: PriceHistoryItem)
    func didGetError(_ error: Error)
}

class PriceListPresenter: PriceListPresenterProtocol {

    weak var view: PriceListViewProtocol?
    private let interactor: PriceListInteractorProtocol
    private let wireframe: PriceListWireframeProtocol
    private var prices = [PriceModel]()
    private var timer: Timer?
    
    init(interactor: PriceListInteractorProtocol, wireframe: PriceListWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - PriceListPresenterProtocol
    
    func viewDidLoad() {
        interactor.retrievePriceHisrory()
    }
    
    func didSelectPrice(at indexPath: IndexPath) {
        let model = prices[indexPath.row]
        wireframe.openPriceDetail(for: model.date)
    }
    
    func didRetrivePrices(_ prices: [PriceHistoryItem]) {
        let models = prices.map({ createModel(from: $0) })
        self.prices = models
        DispatchQueue.main.async {
            self.view?.reload(with: models)
        }
    }
    
    func didRetriveCurrentPrice(_ price: PriceHistoryItem) {
        guard prices.count > 0 else { return }
        let model = createModel(from: price)
        prices[0] = model
        DispatchQueue.main.async {
            self.view?.reload(with: self.prices)
        }
    }
    
    func didGetError(_ error: Error) {
        view?.showAlert(error.localizedDescription)
    }
    
    // MARK: - Private
    
    private func createModel(from historyItem: PriceHistoryItem) -> PriceModel {
        let date = DateFormatter.yyyyMMdd.date(from: historyItem.date) ?? Date()
        let title = DateFormatter.medium.string(from: date)
        
        let currencyFormatter = NumberFormatter.currency
        currencyFormatter.currencySymbol = Currency.EUR.symbol
        let value = currencyFormatter.string(from: NSNumber(value: historyItem.value)) ?? ""
        
        return PriceModel(title: title, value: value, date: historyItem.date)
    }
}
