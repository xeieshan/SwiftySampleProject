//
//  Optional+.swift
//  TalesApp
//
//  Created by Zeeshan Haider on 14/10/2017.
//  Copyright © 2017 XYZco. All rights reserved.
//

import Foundation
extension Optional {
    
    var not: Bool {
        switch self {
        case .none:
            return false
        case .some(let wrapped):
            if let value = wrapped as? Bool {
                return !value
            } else {
                return false
            }
        }
    }
}
