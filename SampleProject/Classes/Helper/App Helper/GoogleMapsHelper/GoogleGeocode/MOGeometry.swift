//
//  MOGeometry.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOGeometry: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let locationType = "location_type"
    static let viewport = "viewport"
    static let location = "location"
  }

  // MARK: Properties
  public var locationType: String?
  public var viewport: MOViewport?
  public var location: MOLocation?

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
    locationType = json[SerializationKeys.locationType].string
    viewport = MOViewport(json: json[SerializationKeys.viewport])
    location = MOLocation(json: json[SerializationKeys.location])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = locationType { dictionary[SerializationKeys.locationType] = value }
    if let value = viewport { dictionary[SerializationKeys.viewport] = value.dictionaryRepresentation() }
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.locationType = aDecoder.decodeObject(forKey: SerializationKeys.locationType) as? String
    self.viewport = aDecoder.decodeObject(forKey: SerializationKeys.viewport) as? MOViewport
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? MOLocation
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(locationType, forKey: SerializationKeys.locationType)
    aCoder.encode(viewport, forKey: SerializationKeys.viewport)
    aCoder.encode(location, forKey: SerializationKeys.location)
  }

}
