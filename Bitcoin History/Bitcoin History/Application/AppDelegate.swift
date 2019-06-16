//
//  AppDelegate.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit
import PriceCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerDependencies()
        window = UIWindow()
        window?.makeKeyAndVisible()
        let priceListViewController = PriceListWireframe.createPriceListModule()
        window?.rootViewController = UINavigationController(rootViewController: priceListViewController)
        
        return true
    }
    
    private func registerDependencies() {
        PriceServicesRegistrator.register()
    }
}
