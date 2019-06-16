//
//  TodayPresenter.swift
//  Bitcoin History Widget
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import PriceCore
import Utils

protocol TodayPresenterProtocol: class {
    func viewDidLoad()
    func didRetriveAmount(_ amount: Amount)
}

class TodayPresenter: TodayPresenterProtocol {

    weak var view: TodayViewProtocol?
    private let interactor: TodayInteractorProtocol
    
    init(interactor: TodayInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.retriveAmount()
    }
    
    func didRetriveAmount(_ amount: Amount) {
        let formatter = NumberFormatter.currency
        formatter.currencySymbol = amount.symbol
        DispatchQueue.main.async { [weak self] in
            let amount = formatter.string(from: NSNumber(value: amount.value)) ?? ""
            self?.view?.update(amount)
        }
    }
    
}
