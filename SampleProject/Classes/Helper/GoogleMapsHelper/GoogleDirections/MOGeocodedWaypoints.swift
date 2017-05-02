//
//  MOGeocodedWaypoints.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MOGeocodedWaypoints: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let types = "types"
    static let geocoderStatus = "geocoder_status"
    static let placeId = "place_id"
  }

  // MARK: Properties
  public var types: [String]?
  public var geocoderStatus: String?
  public var placeId: String?

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
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
    geocoderStatus = json[SerializationKeys.geocoderStatus].string
    placeId = json[SerializationKeys.placeId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = geocoderStatus { dictionary[SerializationKeys.geocoderStatus] = value }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.geocoderStatus = aDecoder.decodeObject(forKey: SerializationKeys.geocoderStatus) as? String
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(geocoderStatus, forKey: SerializationKeys.geocoderStatus)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
  }

}
