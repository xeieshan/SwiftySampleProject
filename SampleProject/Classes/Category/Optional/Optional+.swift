//
//  Optional+.swift
//  <#Project Name#>
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
    
    func `or`(_ value : Wrapped?) -> Optional {
        return self ?? value
    }
    func `or`(_ value: Wrapped) -> Wrapped {
        return self ?? value
    }
    
    
    // `then` function executes the closure if there is some value
    func then(_ handler: (Wrapped) -> Void) {
        switch self {
        case .some(let wrapped): return handler(wrapped)
        case .none: break
        }
    }
    /*
         var optional : Bool? = nil
         //optional.not
         var optionalS : String? = nil
         optionalS.then { (string) in
             debugPrint(string)
         }

         optionalS.then{ debugPrint($0) }
     */
}
