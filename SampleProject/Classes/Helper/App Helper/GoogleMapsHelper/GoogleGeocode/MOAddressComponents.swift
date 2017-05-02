//
//  MOAddressComponents.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOAddressComponents: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let longName = "long_name"
    static let shortName = "short_name"
    static let types = "types"
  }

  // MARK: Properties
  public var longName: String?
  public var shortName: String?
  public var types: [String]?

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
    longName = json[SerializationKeys.longName].string
    shortName = json[SerializationKeys.shortName].string
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = longName { dictionary[SerializationKeys.longName] = value }
    if let value = shortName { dictionary[SerializationKeys.shortName] = value }
    if let value = types { dictionary[SerializationKeys.types] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.longName = aDecoder.decodeObject(forKey: SerializationKeys.longName) as? String
    self.shortName = aDecoder.decodeObject(forKey: SerializationKeys.shortName) as? String
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(longName, forKey: SerializationKeys.longName)
    aCoder.encode(shortName, forKey: SerializationKeys.shortName)
    aCoder.encode(types, forKey: SerializationKeys.types)
  }

}
