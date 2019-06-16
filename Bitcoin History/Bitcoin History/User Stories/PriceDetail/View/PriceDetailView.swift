//
//  PriceDetailView.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import Utils

protocol PriceDetailViewProtocol: class, AlertDisplayable {
    func reload(with price: PriceDetailModel)
    func hideLoader()
}

class PriceDetailView: UIViewController, PriceDetailViewProtocol {

    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let presenter: PriceDetailPresenterProtocol
    
    init(presenter: PriceDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: PriceDetailView.className, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rates"
        presenter.viewDidLoad()
    }
    
    // MARK: - PriceDetailViewProtocol
    
    func reload(with price: PriceDetailModel) {
        eurLabel.text = price.eurValue
        usdLabel.text = price.usdValue
        gbpLabel.text = price.gbpValue
    }
    
    func hideLoader() {
        activityIndicator.isHidden = true
    }
}
