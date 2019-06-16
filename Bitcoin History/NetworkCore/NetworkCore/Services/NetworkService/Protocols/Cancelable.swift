//
//  Cancelable.swift
//  NetworkCore
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public protocol Cancelable {
    func cancel()
}

extension URLSessionDataTask: Cancelable { }
