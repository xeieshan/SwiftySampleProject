//
//  MODuration.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MODuration: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let text = "text"
    static let value = "value"
  }

  // MARK: Properties
  public var text: String?
  public var value: Int?

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
    text = json[SerializationKeys.text].string
    value = json[SerializationKeys.value].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = value { dictionary[SerializationKeys.value] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(value, forKey: SerializationKeys.value)
  }

}
