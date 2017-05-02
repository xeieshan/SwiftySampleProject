//
//  MOGoogleDirection.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MOGoogleDirection: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let routes = "routes"
    static let geocodedWaypoints = "geocoded_waypoints"
  }

  // MARK: Properties
  public var status: String?
  public var routes: [MORoutes]?
  public var geocodedWaypoints: [MOGeocodedWaypoints]?

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
    status = json[SerializationKeys.status].string
    if let items = json[SerializationKeys.routes].array { routes = items.map { MORoutes(json: $0) } }
    if let items = json[SerializationKeys.geocodedWaypoints].array { geocodedWaypoints = items.map { MOGeocodedWaypoints(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = routes { dictionary[SerializationKeys.routes] = value.map { $0.dictionaryRepresentation() } }
    if let value = geocodedWaypoints { dictionary[SerializationKeys.geocodedWaypoints] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.routes = aDecoder.decodeObject(forKey: SerializationKeys.routes) as? [MORoutes]
    self.geocodedWaypoints = aDecoder.decodeObject(forKey: SerializationKeys.geocodedWaypoints) as? [MOGeocodedWaypoints]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(routes, forKey: SerializationKeys.routes)
    aCoder.encode(geocodedWaypoints, forKey: SerializationKeys.geocodedWaypoints)
  }

}
