//
//  MOTerms.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOTerms: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let offset = "offset"
    static let value = "value"
  }

  // MARK: Properties
  public var offset: Int?
  public var value: String?

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
    offset = json[SerializationKeys.offset].int
    value = json[SerializationKeys.value].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = offset { dictionary[SerializationKeys.offset] = value }
    if let value = value { dictionary[SerializationKeys.value] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.offset = aDecoder.decodeObject(forKey: SerializationKeys.offset) as? Int
    self.value = aDecoder.decodeObject(forKey: SerializationKeys.value) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(offset, forKey: SerializationKeys.offset)
    aCoder.encode(value, forKey: SerializationKeys.value)
  }

}
