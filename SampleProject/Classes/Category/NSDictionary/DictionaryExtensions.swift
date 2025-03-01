//
//  DictionaryExtensions.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 8/24/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

import Foundation


// MARK: - Methods
extension Dictionary {
    
    /// Check if key exists in dictionary.
    ///
    /// - Parameter key: key to search for
    /// - Returns: true if key exists in dictionary.
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// JSON Data from dictionary.
    ///
    /// - Parameter prettify: set true to prettify data (default is false).
    /// - Returns: optional JSON Data (if applicable).
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return jsonData
        } catch {
            return nil
        }
    }
    
    /// JSON String from dictionary.
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
}


// MARK: - Methods (ExpressibleByStringLiteral)
extension Dictionary where Key: ExpressibleByStringLiteral {
    
    /// Lowercase all keys in dictionary.
    mutating func lowercaseAllKeys() {
        // http://stackoverflow.com/questions/33180028/extend-dictionary-where-key-is-of-type-string
        for key in self.keys {
            if let lowercaseKey = String(describing: key).lowercased() as? Key {
                self[lowercaseKey] = self.removeValue(forKey: key)
            }
        }
    }
    
}
