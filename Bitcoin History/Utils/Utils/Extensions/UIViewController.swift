//
//  UIViewController.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public protocol AlertDisplayable {
    func showAlert(_ text: String)
}

public extension AlertDisplayable where Self: UIViewController {
    func showAlert(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
