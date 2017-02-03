//
//  String.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 02/03/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation

//Usage in end

public extension String {
    
    /**
     Returns the langauge of a String
     
     NOTE: String has to be at least 4 characters, otherwise the method will return nil.
     
     - returns: String! Returns a string representing the langague of the string (e.g. en, fr, or und for undefined).
     */
    func detectLanguage() -> String? {
        if self.length > 4 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeLanguage], options: 0)
            tagger.string = self
            return tagger.tag(at: 0, scheme: NSLinguisticTagSchemeLanguage, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }
    
    /**
     Returns the script of a String
     
     - returns: String! returns a string representing the script of the String (e.g. Latn, Hans).
     */
    func detectScript() -> String? {
        if self.length > 1 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeScript], options: 0)
            tagger.string = self
            return tagger.tag(at: 0, scheme: NSLinguisticTagSchemeScript, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }
    
    /**
     Check the text direction of a given String.
     
     NOTE: String has to be at least 4 characters, otherwise the method will return false.
     
     - returns: Bool The Bool will return true if the string was writting in a right to left langague (e.g. Arabic, Hebrew)
     
     */
    var isRightToLeft : Bool {
        let language = self.detectLanguage()
        return (language == "ar" || language == "he")
    }
    
    
    //MARK: - Usablity & Social
    
    /**
     Check that a String is only made of white spaces, and new line characters.
     
     - returns: Bool
     */
    func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length == 0
    }
    
    /**
     Checks if a string is an email address using NSDataDetector.
     
     - returns: Bool
     */
//    var isEmail: Bool {
//        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, length))
//        
//        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
//    }
    
    /**
     Check that a String is 'tweetable' can be used in a tweet.
     
     - returns: Bool
     */
    func isTweetable() -> Bool {
        let tweetLength = 140,
        // Each link takes 23 characters in a tweet (assuming all links are https).
        linksLength = self.getLinks().count * 23,
        remaining = tweetLength - linksLength
        
        if linksLength != 0 {
            return remaining < 0
        } else {
            return !(self.utf16.count > tweetLength || self.utf16.count == 0 || self.isOnlyEmptySpacesAndNewLineCharacters())
        }
    }
    
    /**
     Gets an array of Strings for all links found in a String
     
     - returns: [String]
     */
    func getLinks() -> [String] {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let links = detector?.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, length)).map {$0 }
        
        return links!.filter { link in
            return link.url != nil
            }.map { link -> String in
                return link.url!.absoluteString
        }
    }
    
    /**
     Gets an array of URLs for all links found in a String
     
     - returns: [NSURL]
     */
    func getURLs() -> [URL] {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let links = detector?.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, length)).map {$0 }
        
        return links!.filter { link in
            return link.url != nil
            }.map { link -> URL in
                return link.url!
        }
    }
    
    
    /**
     Gets an array of dates for all dates found in a String
     
     - returns: [NSDate]
     */
    func utilities_dateValue() -> [Date] {
        let error: NSErrorPointer = nil
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        } catch let error1 as NSError {
            error?.pointee = error1
            detector = nil
        }
        let dates = detector?.matches(in: self, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, self.utf16.count)) .map {$0 }
        
        return dates!.filter { date in
            return date.date != nil
            }.map { link -> Date in
                return link.date!
        }
    }
    
    /**
     Gets an array of strings (hashtags #acme) for all links found in a String
     
     - returns: [String]
     */
    func getHashtags() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "#(\\w+)", options: NSRegularExpression.Options.caseInsensitive)
        let results = hashtagDetector?.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }
        
        return results?.map({
            (self as NSString).substring(with: $0.rangeAt(1))
        })
    }
    
    /**
     Gets an array of distinct strings (hashtags #acme) for all hashtags found in a String
     
     - returns: [String]
     */
    func getUniqueHashtags() -> [String]? {
        return Array(Set(getHashtags()!))
    }
    
    
    
    /**
     Gets an array of strings (mentions @apple) for all mentions found in a String
     
     - returns: [String]
     */
    func getMentions() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "@(\\w+)", options: NSRegularExpression.Options.caseInsensitive)
        let results = hashtagDetector?.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }
        
        return results?.map({
            (self as NSString).substring(with: $0.rangeAt(1))
        })
    }
    
    /**
     Check if a String contains a Date in it.
     
     - returns: Bool with true value if it does
     */
    func getUniqueMentions() -> [String]? {
        return Array(Set(getMentions()!))
    }
    
    
    /**
     Check if a String contains a link in it.
     
     - returns: Bool with true value if it does
     */
    func containsLink() -> Bool {
        return self.getLinks().count > 0
    }
    
    /**
     Check if a String contains a date in it.
     
     - returns: Bool with true value if it does
     */
    func containsDate() -> Bool {
        return self.utilities_dateValue().count > 0
    }
    
    /**
     - returns: Base64 encoded string
     */
    func encodeToBase64Encoding() -> String {
        let utf8str = self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        return utf8str.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }
    
    /**
     - returns: Decoded Base64 string
     */
    func decodeFromBase64Encoding() -> String {
        let base64data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        return NSString(data: base64data!, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    
    func urlEncode() -> String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }
    
    //    func urlDecode() -> String {
    //        return stringByRemovingPercentEncoding!
    //    }
    
    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards), left != right && leftRange.upperBound != rightRange.lowerBound
            else { return nil }
        
        return self[leftRange.upperBound...index(before: rightRange.lowerBound)]
        
    }
    
    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    func camelize() -> String {
        let source = clean(" ", allOf: "-", "_")
        if source.characters.contains(" ") {
            let first = source.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let cammel = NSString(format: "%@", (source as NSString).capitalized.replacingOccurrences(of: " ", with: "", options: [], range: nil)) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercased.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    func capitalize() -> String {
        return capitalized
    }
    
    func contains(_ substring: String) -> Bool {
        return range(of: substring) != nil
    }
    
    func chompLeft(_ prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return self[startIndex..<prefixRange.lowerBound]
            } else {
                return self[prefixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func chompRight(_ suffix: String) -> String {
        if let suffixRange = range(of: suffix, options: .backwards) {
            if suffixRange.upperBound >= endIndex {
                return self[startIndex..<suffixRange.lowerBound]
            } else {
                return self[suffixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return components.joined(separator: " ")
    }
    
    func clean(_ with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count-1
    }
    
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(_ prefix: String) -> String {
        if startsWith(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(_ suffix: String) -> String {
        if endsWith(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
    func indexOf(_ substring: String) -> Int? {
        if let range = range(of: substring) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        }
        return nil
    }
    
    //    func initials() -> String {
    //        let words = self.components(separatedBy: " ")
    //        return words.reduce(""){$0 + $1[0...0]}
    //    }
    //
    //    func initialsFirstAndLast() -> String {
    //        let words = self.components(separatedBy: " ")
    //        return words.reduce("") { ($0 == "" ? "" : $0[0...0]) + $1[0...0]}
    //    }
    
    func isAlpha() -> Bool {
        for chr in characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
//    func isAlphaNumeric() -> Bool {
//        let alphaNumeric = CharacterSet.alphanumerics
//        return components(separatedBy: alphaNumeric).joined(separator: "").length == 0
//    }
    
    func isEmpty() -> Bool {
        let nonWhitespaceSet = CharacterSet.whitespacesAndNewlines.inverted
        return components(separatedBy: nonWhitespaceSet).joined(separator: "").length != 0
    }
    
//    func isNumeric() -> Bool {
//        if let _ = NumberFormatter().number(from: self) {
//            return true
//        }
//        return false
//    }
    
    func join<S : Sequence>(_ elements: S) -> String {
        return elements.map{String(describing: $0)}.joined(separator: self)
    }
    
    func latinize() -> String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
//    func lines() -> [String] {
//        return characters.split{$0 == "\n"}.map(String.init)
//    }
    
    //    var length: Int {
    //        get {
    //            return self.characters.count
    //        }
    //    }
    
    var length: Int {
        return characters.count
    }
    
    func pad(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self, string.times(n)])
    }
    
    func padLeft(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self])
    }
    
    func padRight(_ n: Int, _ string: String = " ") -> String {
        return "".join([self, string.times(n)])
    }
    
    func slugify() -> String {
        let slugCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
        return latinize().lowercased()
            .components(separatedBy: slugCharacterSet.inverted)
            .filter { $0 != "" }
            .joined(separator: "-")
    }
    
    func split(_ separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    func startsWith(_ prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    func stripPunctuation() -> String {
        return components(separatedBy: .punctuationCharacters)
            .joined(separator: "")
            .components(separatedBy: " ")
            .filter { $0 != "" }
            .joined(separator: " ")
    }
    
    func times(_ n: Int) -> String {
        return (0..<n).reduce("") { $0.0 + self }
    }
    
    func toFloat() -> Float? {
        if let number = NumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = NumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
    
    func toDouble(_ locale: Locale = Locale.current) -> Double? {
        let nf = NumberFormatter()
        nf.locale = locale
        if let number = nf.number(from: self) {
            return number.doubleValue
        }
        return nil
    }
    
    func toBool() -> Bool? {
        let trimmed = self.trimmed.lowercased()
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func toDateTime(_ format : String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return toDate(format)
    }
    
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        
        return self
    }
    
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted, options: NSString.CompareOptions.backwards) {
            return self[startIndex..<range.upperBound]
        }
        
        return self
    }
    
//    func trimmed() -> String {
//        return trimmedLeft().trimmedRight()
//    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            
            return self[startIndex..<endIndex]
        }
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.characters.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    fileprivate struct HTMLEntities {
        static let characterEntities : [String: Character] = [
            
            // XML predefined entities:
            "&quot;"     : "\"",
            "&amp;"      : "&",
            "&apos;"     : "'",
            "&lt;"       : "<",
            "&gt;"       : ">",
            
            // HTML character entity references:
            "&nbsp;"     : "\u{00A0}",
            "&iexcl;"    : "\u{00A1}",
            "&cent;"     : "\u{00A2}",
            "&pound;"    : "\u{00A3}",
            "&curren;"   : "\u{00A4}",
            "&yen;"      : "\u{00A5}",
            "&brvbar;"   : "\u{00A6}",
            "&sect;"     : "\u{00A7}",
            "&uml;"      : "\u{00A8}",
            "&copy;"     : "\u{00A9}",
            "&ordf;"     : "\u{00AA}",
            "&laquo;"    : "\u{00AB}",
            "&not;"      : "\u{00AC}",
            "&shy;"      : "\u{00AD}",
            "&reg;"      : "\u{00AE}",
            "&macr;"     : "\u{00AF}",
            "&deg;"      : "\u{00B0}",
            "&plusmn;"   : "\u{00B1}",
            "&sup2;"     : "\u{00B2}",
            "&sup3;"     : "\u{00B3}",
            "&acute;"    : "\u{00B4}",
            "&micro;"    : "\u{00B5}",
            "&para;"     : "\u{00B6}",
            "&middot;"   : "\u{00B7}",
            "&cedil;"    : "\u{00B8}",
            "&sup1;"     : "\u{00B9}",
            "&ordm;"     : "\u{00BA}",
            "&raquo;"    : "\u{00BB}",
            "&frac14;"   : "\u{00BC}",
            "&frac12;"   : "\u{00BD}",
            "&frac34;"   : "\u{00BE}",
            "&iquest;"   : "\u{00BF}",
            "&Agrave;"   : "\u{00C0}",
            "&Aacute;"   : "\u{00C1}",
            "&Acirc;"    : "\u{00C2}",
            "&Atilde;"   : "\u{00C3}",
            "&Auml;"     : "\u{00C4}",
            "&Aring;"    : "\u{00C5}",
            "&AElig;"    : "\u{00C6}",
            "&Ccedil;"   : "\u{00C7}",
            "&Egrave;"   : "\u{00C8}",
            "&Eacute;"   : "\u{00C9}",
            "&Ecirc;"    : "\u{00CA}",
            "&Euml;"     : "\u{00CB}",
            "&Igrave;"   : "\u{00CC}",
            "&Iacute;"   : "\u{00CD}",
            "&Icirc;"    : "\u{00CE}",
            "&Iuml;"     : "\u{00CF}",
            "&ETH;"      : "\u{00D0}",
            "&Ntilde;"   : "\u{00D1}",
            "&Ograve;"   : "\u{00D2}",
            "&Oacute;"   : "\u{00D3}",
            "&Ocirc;"    : "\u{00D4}",
            "&Otilde;"   : "\u{00D5}",
            "&Ouml;"     : "\u{00D6}",
            "&times;"    : "\u{00D7}",
            "&Oslash;"   : "\u{00D8}",
            "&Ugrave;"   : "\u{00D9}",
            "&Uacute;"   : "\u{00DA}",
            "&Ucirc;"    : "\u{00DB}",
            "&Uuml;"     : "\u{00DC}",
            "&Yacute;"   : "\u{00DD}",
            "&THORN;"    : "\u{00DE}",
            "&szlig;"    : "\u{00DF}",
            "&agrave;"   : "\u{00E0}",
            "&aacute;"   : "\u{00E1}",
            "&acirc;"    : "\u{00E2}",
            "&atilde;"   : "\u{00E3}",
            "&auml;"     : "\u{00E4}",
            "&aring;"    : "\u{00E5}",
            "&aelig;"    : "\u{00E6}",
            "&ccedil;"   : "\u{00E7}",
            "&egrave;"   : "\u{00E8}",
            "&eacute;"   : "\u{00E9}",
            "&ecirc;"    : "\u{00EA}",
            "&euml;"     : "\u{00EB}",
            "&igrave;"   : "\u{00EC}",
            "&iacute;"   : "\u{00ED}",
            "&icirc;"    : "\u{00EE}",
            "&iuml;"     : "\u{00EF}",
            "&eth;"      : "\u{00F0}",
            "&ntilde;"   : "\u{00F1}",
            "&ograve;"   : "\u{00F2}",
            "&oacute;"   : "\u{00F3}",
            "&ocirc;"    : "\u{00F4}",
            "&otilde;"   : "\u{00F5}",
            "&ouml;"     : "\u{00F6}",
            "&divide;"   : "\u{00F7}",
            "&oslash;"   : "\u{00F8}",
            "&ugrave;"   : "\u{00F9}",
            "&uacute;"   : "\u{00FA}",
            "&ucirc;"    : "\u{00FB}",
            "&uuml;"     : "\u{00FC}",
            "&yacute;"   : "\u{00FD}",
            "&thorn;"    : "\u{00FE}",
            "&yuml;"     : "\u{00FF}",
            "&OElig;"    : "\u{0152}",
            "&oelig;"    : "\u{0153}",
            "&Scaron;"   : "\u{0160}",
            "&scaron;"   : "\u{0161}",
            "&Yuml;"     : "\u{0178}",
            "&fnof;"     : "\u{0192}",
            "&circ;"     : "\u{02C6}",
            "&tilde;"    : "\u{02DC}",
            "&Alpha;"    : "\u{0391}",
            "&Beta;"     : "\u{0392}",
            "&Gamma;"    : "\u{0393}",
            "&Delta;"    : "\u{0394}",
            "&Epsilon;"  : "\u{0395}",
            "&Zeta;"     : "\u{0396}",
            "&Eta;"      : "\u{0397}",
            "&Theta;"    : "\u{0398}",
            "&Iota;"     : "\u{0399}",
            "&Kappa;"    : "\u{039A}",
            "&Lambda;"   : "\u{039B}",
            "&Mu;"       : "\u{039C}",
            "&Nu;"       : "\u{039D}",
            "&Xi;"       : "\u{039E}",
            "&Omicron;"  : "\u{039F}",
            "&Pi;"       : "\u{03A0}",
            "&Rho;"      : "\u{03A1}",
            "&Sigma;"    : "\u{03A3}",
            "&Tau;"      : "\u{03A4}",
            "&Upsilon;"  : "\u{03A5}",
            "&Phi;"      : "\u{03A6}",
            "&Chi;"      : "\u{03A7}",
            "&Psi;"      : "\u{03A8}",
            "&Omega;"    : "\u{03A9}",
            "&alpha;"    : "\u{03B1}",
            "&beta;"     : "\u{03B2}",
            "&gamma;"    : "\u{03B3}",
            "&delta;"    : "\u{03B4}",
            "&epsilon;"  : "\u{03B5}",
            "&zeta;"     : "\u{03B6}",
            "&eta;"      : "\u{03B7}",
            "&theta;"    : "\u{03B8}",
            "&iota;"     : "\u{03B9}",
            "&kappa;"    : "\u{03BA}",
            "&lambda;"   : "\u{03BB}",
            "&mu;"       : "\u{03BC}",
            "&nu;"       : "\u{03BD}",
            "&xi;"       : "\u{03BE}",
            "&omicron;"  : "\u{03BF}",
            "&pi;"       : "\u{03C0}",
            "&rho;"      : "\u{03C1}",
            "&sigmaf;"   : "\u{03C2}",
            "&sigma;"    : "\u{03C3}",
            "&tau;"      : "\u{03C4}",
            "&upsilon;"  : "\u{03C5}",
            "&phi;"      : "\u{03C6}",
            "&chi;"      : "\u{03C7}",
            "&psi;"      : "\u{03C8}",
            "&omega;"    : "\u{03C9}",
            "&thetasym;" : "\u{03D1}",
            "&upsih;"    : "\u{03D2}",
            "&piv;"      : "\u{03D6}",
            "&ensp;"     : "\u{2002}",
            "&emsp;"     : "\u{2003}",
            "&thinsp;"   : "\u{2009}",
            "&zwnj;"     : "\u{200C}",
            "&zwj;"      : "\u{200D}",
            "&lrm;"      : "\u{200E}",
            "&rlm;"      : "\u{200F}",
            "&ndash;"    : "\u{2013}",
            "&mdash;"    : "\u{2014}",
            "&lsquo;"    : "\u{2018}",
            "&rsquo;"    : "\u{2019}",
            "&sbquo;"    : "\u{201A}",
            "&ldquo;"    : "\u{201C}",
            "&rdquo;"    : "\u{201D}",
            "&bdquo;"    : "\u{201E}",
            "&dagger;"   : "\u{2020}",
            "&Dagger;"   : "\u{2021}",
            "&bull;"     : "\u{2022}",
            "&hellip;"   : "\u{2026}",
            "&permil;"   : "\u{2030}",
            "&prime;"    : "\u{2032}",
            "&Prime;"    : "\u{2033}",
            "&lsaquo;"   : "\u{2039}",
            "&rsaquo;"   : "\u{203A}",
            "&oline;"    : "\u{203E}",
            "&frasl;"    : "\u{2044}",
            "&euro;"     : "\u{20AC}",
            "&image;"    : "\u{2111}",
            "&weierp;"   : "\u{2118}",
            "&real;"     : "\u{211C}",
            "&trade;"    : "\u{2122}",
            "&alefsym;"  : "\u{2135}",
            "&larr;"     : "\u{2190}",
            "&uarr;"     : "\u{2191}",
            "&rarr;"     : "\u{2192}",
            "&darr;"     : "\u{2193}",
            "&harr;"     : "\u{2194}",
            "&crarr;"    : "\u{21B5}",
            "&lArr;"     : "\u{21D0}",
            "&uArr;"     : "\u{21D1}",
            "&rArr;"     : "\u{21D2}",
            "&dArr;"     : "\u{21D3}",
            "&hArr;"     : "\u{21D4}",
            "&forall;"   : "\u{2200}",
            "&part;"     : "\u{2202}",
            "&exist;"    : "\u{2203}",
            "&empty;"    : "\u{2205}",
            "&nabla;"    : "\u{2207}",
            "&isin;"     : "\u{2208}",
            "&notin;"    : "\u{2209}",
            "&ni;"       : "\u{220B}",
            "&prod;"     : "\u{220F}",
            "&sum;"      : "\u{2211}",
            "&minus;"    : "\u{2212}",
            "&lowast;"   : "\u{2217}",
            "&radic;"    : "\u{221A}",
            "&prop;"     : "\u{221D}",
            "&infin;"    : "\u{221E}",
            "&ang;"      : "\u{2220}",
            "&and;"      : "\u{2227}",
            "&or;"       : "\u{2228}",
            "&cap;"      : "\u{2229}",
            "&cup;"      : "\u{222A}",
            "&int;"      : "\u{222B}",
            "&there4;"   : "\u{2234}",
            "&sim;"      : "\u{223C}",
            "&cong;"     : "\u{2245}",
            "&asymp;"    : "\u{2248}",
            "&ne;"       : "\u{2260}",
            "&equiv;"    : "\u{2261}",
            "&le;"       : "\u{2264}",
            "&ge;"       : "\u{2265}",
            "&sub;"      : "\u{2282}",
            "&sup;"      : "\u{2283}",
            "&nsub;"     : "\u{2284}",
            "&sube;"     : "\u{2286}",
            "&supe;"     : "\u{2287}",
            "&oplus;"    : "\u{2295}",
            "&otimes;"   : "\u{2297}",
            "&perp;"     : "\u{22A5}",
            "&sdot;"     : "\u{22C5}",
            "&lceil;"    : "\u{2308}",
            "&rceil;"    : "\u{2309}",
            "&lfloor;"   : "\u{230A}",
            "&rfloor;"   : "\u{230B}",
            "&lang;"     : "\u{2329}",
            "&rang;"     : "\u{232A}",
            "&loz;"      : "\u{25CA}",
            "&spades;"   : "\u{2660}",
            "&clubs;"    : "\u{2663}",
            "&hearts;"   : "\u{2665}",
            "&diams;"    : "\u{2666}",
            ]
    }
    
    // Convert the number in the string to the corresponding
    // Unicode character, e.g.
    //    decodeNumeric("64", 10)   --> "@"
    //    decodeNumeric("20ac", 16) --> "€"
    fileprivate func decodeNumeric(_ string : String, base : Int32) -> Character? {
        let code = UInt32(strtoul(string, nil, base))
        return Character(UnicodeScalar(code)!)
    }
    
    // Decode the HTML character entity to the corresponding
    // Unicode character, return `nil` for invalid input.
    //     decode("&#64;")    --> "@"
    //     decode("&#x20ac;") --> "€"
    //     decode("&lt;")     --> "<"
    //     decode("&foo;")    --> nil
    fileprivate func decode(_ entity : String) -> Character? {
        if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
            return decodeNumeric(entity.substring(from: entity.characters.index(entity.startIndex, offsetBy: 3)), base: 16)
        } else if entity.hasPrefix("&#") {
            return decodeNumeric(entity.substring(from: entity.characters.index(entity.startIndex, offsetBy: 2)), base: 10)
        } else {
            return HTMLEntities.characterEntities[entity]
        }
    }
    
    
    /// Returns a new string made by replacing in the `String`
    /// all HTML character entity references with the corresponding
    /// character.
    func decodeHTML() -> String {
        var result = ""
        var position = startIndex
        
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self.range(of: "&", range: position ..< endIndex) {
            result.append(self[position ..< ampRange.lowerBound])
            position = ampRange.lowerBound
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            if let semiRange = self.range(of: ";", range: position ..< endIndex) {
                let entity = self[position ..< semiRange.upperBound]
                position = semiRange.upperBound
                
                if let decoded = decode(entity) {
                    // Replace by decoded character:
                    result.append(decoded)
                } else {
                    // Invalid entity, copy verbatim:
                    result.append(entity)
                }
            } else {
                // No matching ';'.
                break
            }
        }
        // Copy remaining characters to `result`:
        result.append(self[position ..< endIndex])
        return result
    }
    
}
/*
Usage

import SwiftString
Methods

between(left, right)

"<a>foo</a>".between("<a>", "</a>") // "foo"
"<a><a>foo</a></a>".between("<a>", "</a>") // "<a>foo</a>"
"<a>foo".between("<a>", "</a>") // nil
"Some strings } are very {weird}, dont you think?".between("{", "}") // "weird"
"<a></a>".between("<a>", "</a>") // nil
"<a>foo</a>".between("<a>", "<a>") // nil
camelize()

"os version".camelize() // "osVersion"
"HelloWorld".camelize() // "helloWorld"
"someword With Characters".camelize() // "somewordWithCharacters"
"data_rate".camelize() // "dataRate"
"background-color".camelize() // "backgroundColor"
capitalize()

"hello world".capitalize() // "Hello World"
chompLeft(string)

"foobar".chompLeft("foo") // "bar"
"foobar".chompLeft("bar") // "foo"
chompRight(string)

"foobar".chompRight("bar") // "foo"
"foobar".chompRight("foo") // "bar"
collapseWhitespace()

"  String   \t libraries are   \n\n\t fun\n!  ".collapseWhitespace() // "String libraries are fun !")
contains(substring)

"foobar".contains("foo") // true
"foobar".contains("bar") // true
"foobar".contains("something") // false
count(string)

"hi hi ho hey hihey".count("hi") // 3
decodeHTML()

"The Weekend &#8216;King Of The Fall&#8217;".decodeHTML() // "The Weekend ‘King Of The Fall’"
"<strong> 4 &lt; 5 &amp; 3 &gt; 2 .</strong> Price: 12 &#x20ac;.  &#64; ".decodeHTML() // "<strong> 4 < 5 & 3 > 2 .</strong> Price: 12 €.  @ "
"this is so &quot;good&quot;".decodeHTML() // "this is so \"good\""
endsWith(suffix)

"hello world".endsWith("world") // true
"hello world".endsWith("foo") // false
ensureLeft(prefix)

"/subdir".ensureLeft("/") // "/subdir"
"subdir".ensureLeft("/") // "/subdir"
ensureRight(suffix)

"subdir/".ensureRight("/") // "subdir/"
"subdir".ensureRight("/") // "subdir/"
indexOf(substring)

"hello".indexOf("hell"), // 0
"hello".indexOf("lo"), // 3
"hello".indexOf("world") // nil
initials()

"First".initials(), // "F"
"First Last".initials(), // "FL"
"First Middle1 Middle2 Middle3 Last".initials() // "FMMML"
initialsFirstAndLast()

"First Last".initialsFirstAndLast(), // "FL"
"First Middle1 Middle2 Middle3 Last".initialsFirstAndLast() // "FL"
isAlpha()

"fdafaf3".isAlpha() // false
"afaf".isAlpha() // true
"dfdf--dfd".isAlpha() // false
isAlphaNumeric()

"afaf35353afaf".isAlphaNumeric() // true
"FFFF99fff".isAlphaNumeric() // true
"99".isAlphaNumeric() // true
"afff".isAlphaNumeric() // true
"-33".isAlphaNumeric() // false
"aaff..".isAlphaNumeric() // false
isEmpty()

" ".isEmpty() // true
"\t\t\t ".isEmpty() // true
"\n\n".isEmpty() // true
"helo".isEmpty() // false
isNumeric()

"abc".isNumeric() // false
"123a".isNumeric() // false
"1".isNumeric() // true
"22".isNumeric() // true
"33.0".isNumeric() // true
"-63.0".isNumeric() // true
join(sequence)

",".join([1,2,3]) // "1,2,3"
",".join([]) // ""
",".join(["a","b","c"]) // "a,b,c"
"! ".join(["hey","who are you?"]) // "hey! who are you?"
latinize()

"šÜįéïöç".latinize() // "sUieioc"
"crème brûlée".latinize() // "creme brulee"
lines()

"test".lines() // ["test"]
"test\nsentence".lines() // ["test", "sentence"]
"test \nsentence".lines() // ["test ", "sentence"]
pad(n, string)

"hello".pad(2) // "  hello  "
"hello".pad(1, "\t") // "\thello\t"
padLeft(n, string)

"hello".padLeft(10) // "          hello"
"what?".padLeft(2, "!") // "!!what?"
padRight(n, string)

"hello".padRight(10) // "hello          "
"hello".padRight(2, "!") // "hello!!"
startsWith(prefix)

"hello world".startsWith("hello") // true
"hello world".startsWith("foo") // false
split(separator)

"hello world".split(" ")[0] // "hello"
"hello world".split(" ")[1] // "world"
"helloworld".split(" ")[0] // "helloworld"
times(n)

"hi".times(3) // "hihihi"
" ".times(10) // "          "
toBool()

"asdwads".toBool() // nil
"true".toBool() // true
"false".toBool() // false
toFloat()

"asdwads".toFloat() // nil
"2.00".toFloat() // 2.0
"2".toFloat() // 2.0
toInt()

"asdwads".toInt() // nil
"2.00".toInt() // 2
"2".toInt() // 2
toDate()

"asdwads".toDate() // nil
"2014-06-03".toDate() // NSDate
toDateTime()

"asdwads".toDateTime() // nil
"2014-06-03 13:15:01".toDateTime() // NSDate
toDouble()

"asdwads".toDouble() // nil
"2.00".toDouble() // 2.0
"2".toDouble() // 2.0
trimmedLeft()

"        How are you? ".trimmedLeft() // "How are you? "
trimmedRight()

" How are you?   ".trimmedRight() // " How are you?"
trimmed()

"    How are you?   ".trimmed() // "How are you?"
slugify()

"Global Thermonuclear Warfare".slugify() // "global-thermonuclear-warfare"
"Crème brûlée".slugify() // "creme-brulee"
stripPunctuation()

"My, st[ring] *full* of %punct)".stripPunctuation() // "My string full of punct"
substring(startIndex, length)

"hello world".substring(0, length: 1) // "h"
"hello world".substring(0, length: 11) // "hello world"
[subscript]

"hello world"[0...1] // "he"
"hello world"[0..<1] // "h"
"hello world"[0] // "h"
"hello world"[0...10] // "hello world"

*/
