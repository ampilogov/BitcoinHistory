//
//  WeakArray.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

final public class WeakArray<T>: Sequence {
    
    // Private
    private let hashTable = NSHashTable<AnyObject>.weakObjects()
    
    // MARK: - Public
    
    public init() { }
    
    public func add(_ element: T) {
        hashTable.add(element as AnyObject)
    }
    
    public func remove(_ element: T) {
        hashTable.remove(element as AnyObject)
    }
    
    public var count: Int {
        return hashTable.count
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    // MARK: - Sequence
    
    public func makeIterator() -> Array<T>.Iterator {
        let elements = hashTable.allObjects.compactMap { $0 as? T }
        return elements.makeIterator()
    }
}
