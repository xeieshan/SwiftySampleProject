//
//  MOStructuredFormatting.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOStructuredFormatting: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let secondaryText = "secondary_text"
    static let mainText = "main_text"
    static let mainTextMatchedSubstrings = "main_text_matched_substrings"
  }

  // MARK: Properties
  public var secondaryText: String?
  public var mainText: String?
  public var mainTextMatchedSubstrings: [MOMainTextMatchedSubstrings]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    secondaryText = json[SerializationKeys.secondaryText].string
    mainText = json[SerializationKeys.mainText].string
    if let items = json[SerializationKeys.mainTextMatchedSubstrings].array { mainTextMatchedSubstrings = items.map { MOMainTextMatchedSubstrings(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = secondaryText { dictionary[SerializationKeys.secondaryText] = value }
    if let value = mainText { dictionary[SerializationKeys.mainText] = value }
    if let value = mainTextMatchedSubstrings { dictionary[SerializationKeys.mainTextMatchedSubstrings] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.secondaryText = aDecoder.decodeObject(forKey: SerializationKeys.secondaryText) as? String
    self.mainText = aDecoder.decodeObject(forKey: SerializationKeys.mainText) as? String
    self.mainTextMatchedSubstrings = aDecoder.decodeObject(forKey: SerializationKeys.mainTextMatchedSubstrings) as? [MOMainTextMatchedSubstrings]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(secondaryText, forKey: SerializationKeys.secondaryText)
    aCoder.encode(mainText, forKey: SerializationKeys.mainText)
    aCoder.encode(mainTextMatchedSubstrings, forKey: SerializationKeys.mainTextMatchedSubstrings)
  }

}
