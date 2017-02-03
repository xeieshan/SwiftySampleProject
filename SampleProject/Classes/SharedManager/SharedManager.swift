//
//  SharedManager.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import Foundation
class SharedManager: NSObject {

    // Can't init is singleton
    private override init() { }
    
    //MARK: Shared Instance
    
    static let sharedInstance: SharedManager = SharedManager()
    
    //MARK: Local Variable
    
    var emptyStringArray : [String] = []
    
}
