//
//  DIContainer.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public class DIContainer {
    
    public static let main = DIContainer()
    private var storage = [AnyHashable: Any]()
    
    public func register<T>(key: T.Type, instance: T) {
        self.storage["\(T.self)"] = instance
    }
    
    public func get<T>(_:T.Type) -> T {
        return storage["\(T.self)"] as! T
    }
}
