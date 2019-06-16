//
//  TodayViewController.swift
//  Bitcoin History Widget
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit

protocol TodayViewProtocol: class {
    func update(_ amountText: String)
}

class TodayView: UIViewController, TodayViewProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    private let presenter: TodayPresenterProtocol
    
    init(presenter: TodayPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: TodayView.className, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - TodayViewProtocol
    
    func update(_ amountText: String) {
        titleLabel.text = amountText
    }
    
}
