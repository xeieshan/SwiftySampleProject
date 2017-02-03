//
//  APIResponse.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//
import Foundation
class APIResponse: NSObject {
    var error: SPError?
    var optionalMessage: String = ""
    var data: AnyObject?

    override init() {
        
    }
    /*
    https://medium.com/swift-programming/swift-typealias-to-the-rescue-b1027fc571e3#.fc5o4ma70
    typealias SuccessHandler = dictResponse: [NSObject : AnyObject], error networkError: NSError) -> APIResponse
    typealias ErrorHandler = (error: NSError, operation: AFHTTPRequestOperation)
    -> Void
    typealias FinishedHandler = () -> Void
    */
    
    class func handleResponse(dictResponse: [String : AnyObject], error networkError: NSError) -> APIResponse {
        let response: APIResponse = APIResponse()
        if networkError != NSNull() {
            var result: [String : AnyObject] = dictResponse 
            if CInt((result["status"] as! Int)) == 0 {
                response.error = SPError(dictResult: result as [NSObject : AnyObject])
                response.data = nil
            }
            else {
                response.optionalMessage = result["message"] as! String
                response.data = (result["result"] as! String as AnyObject?)
            }
        }
        else {
            response.error = SPError(error: networkError)
            response.data = nil
        }
        return response
    }
}
