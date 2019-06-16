//
//  PriceListView.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import Utils

protocol PriceListViewProtocol: class, AlertDisplayable {
    func reload(with prices: [PriceModel])
    func hideLoader()
}

class PriceListView: UIViewController, UITableViewDataSource, UITableViewDelegate, PriceListViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    private let presenter: PriceListPresenterProtocol
    fileprivate var prices = [PriceModel]()
    
    init(presenter: PriceListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: PriceListView.className, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Bitcoin History"
        setupTableView()
        presenter.viewDidLoad()
    }

    // MARK: - UITableViewDataSource
    
    func setupTableView() {
        let nib = UINib(nibName: PriceListCell.className, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: PriceListCell.className)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceListCell.className, for: indexPath)
        if let priceCell = cell as? PriceListCell {
            priceCell.configure(with: prices[indexPath.row])
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectPrice(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - PriceListViewProtocol

    func reload(with prices: [PriceModel]) {
        self.prices = prices
        tableView.reloadData()
    }
    
    func hideLoader() {
        
    }
}
