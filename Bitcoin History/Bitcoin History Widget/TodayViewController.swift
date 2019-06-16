//
//  TodayViewController.swift
//  Bitcoin History Widget
//
//  Created by Vitaliy Ampilogov on 6/16/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import PriceCore
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerDependencies()
        placeView()
    }
    
    private func registerDependencies() {
        PriceServicesRegistrator.register()
    }
    
    func placeView() {
        let viewController = TodayWireframe.createTodayModule()
        addChild(viewController)
        viewController.willMove(toParent: self)
        view.addSubview(viewController.view)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        viewController.didMove(toParent: self)
    }
    
}
