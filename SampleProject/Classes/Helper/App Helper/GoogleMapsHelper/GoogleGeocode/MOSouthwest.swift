//
//  MOSouthwest.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOSouthwest: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lat = "lat"
    static let lng = "lng"
  }

  // MARK: Properties
  public var lat: Float?
  public var lng: Float?

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
    lat = json[SerializationKeys.lat].float
    lng = json[SerializationKeys.lng].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lat { dictionary[SerializationKeys.lat] = value }
    if let value = lng { dictionary[SerializationKeys.lng] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lat = aDecoder.decodeObject(forKey: SerializationKeys.lat) as? Float
    self.lng = aDecoder.decodeObject(forKey: SerializationKeys.lng) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lat, forKey: SerializationKeys.lat)
    aCoder.encode(lng, forKey: SerializationKeys.lng)
  }

}
