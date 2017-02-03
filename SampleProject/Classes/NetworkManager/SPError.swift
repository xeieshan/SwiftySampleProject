//
//  SPError.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
import Foundation
class SPError: AnyObject {
    var errorCode: String = ""
    var message: String = ""
    
    convenience init(dictResult: [AnyHashable: Any]) {
        self.init()
        self.message = (dictResult["error"] as! String)
        if self.message.length == 0 {
            self.message = (dictResult["message"] as! String)
        }
        
    }
    
    convenience init(error: NSError) {
        self.init()
        //self.errorCode = [NSString stringWithFormat:@"%d",[error code]];
        self.message = error.localizedDescription
    }
    
    convenience init(message: String, errorCode code: String) {
        self.init()
        //self.errorCode = code;
        self.message = message
    }
}
