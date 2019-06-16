//
//  NSObject.swift
//  Utils
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation

public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    static var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
