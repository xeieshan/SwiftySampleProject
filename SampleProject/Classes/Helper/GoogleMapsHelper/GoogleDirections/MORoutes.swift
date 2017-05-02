//
//  MORoutes.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MORoutes: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let legs = "legs"
    static let overviewPolyline = "overview_polyline"
    static let bounds = "bounds"
    static let waypointOrder = "waypoint_order"
    static let warnings = "warnings"
    static let copyrights = "copyrights"
  }

  // MARK: Properties
  public var summary: String?
  public var legs: [MOLegs]?
  public var overviewPolyline: MOOverviewPolyline?
  public var bounds: MOBounds?
  public var waypointOrder: [Any]?
  public var warnings: [Any]?
  public var copyrights: String?

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
    summary = json[SerializationKeys.summary].string
    if let items = json[SerializationKeys.legs].array { legs = items.map { MOLegs(json: $0) } }
    overviewPolyline = MOOverviewPolyline(json: json[SerializationKeys.overviewPolyline])
    bounds = MOBounds(json: json[SerializationKeys.bounds])
    if let items = json[SerializationKeys.waypointOrder].array { waypointOrder = items.map { $0.object} }
    if let items = json[SerializationKeys.warnings].array { warnings = items.map { $0.object} }
    copyrights = json[SerializationKeys.copyrights].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = legs { dictionary[SerializationKeys.legs] = value.map { $0.dictionaryRepresentation() } }
    if let value = overviewPolyline { dictionary[SerializationKeys.overviewPolyline] = value.dictionaryRepresentation() }
    if let value = bounds { dictionary[SerializationKeys.bounds] = value.dictionaryRepresentation() }
    if let value = waypointOrder { dictionary[SerializationKeys.waypointOrder] = value }
    if let value = warnings { dictionary[SerializationKeys.warnings] = value }
    if let value = copyrights { dictionary[SerializationKeys.copyrights] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.legs = aDecoder.decodeObject(forKey: SerializationKeys.legs) as? [MOLegs]
    self.overviewPolyline = aDecoder.decodeObject(forKey: SerializationKeys.overviewPolyline) as? MOOverviewPolyline
    self.bounds = aDecoder.decodeObject(forKey: SerializationKeys.bounds) as? MOBounds
    self.waypointOrder = aDecoder.decodeObject(forKey: SerializationKeys.waypointOrder) as? [Any]
    self.warnings = aDecoder.decodeObject(forKey: SerializationKeys.warnings) as? [Any]
    self.copyrights = aDecoder.decodeObject(forKey: SerializationKeys.copyrights) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(legs, forKey: SerializationKeys.legs)
    aCoder.encode(overviewPolyline, forKey: SerializationKeys.overviewPolyline)
    aCoder.encode(bounds, forKey: SerializationKeys.bounds)
    aCoder.encode(waypointOrder, forKey: SerializationKeys.waypointOrder)
    aCoder.encode(warnings, forKey: SerializationKeys.warnings)
    aCoder.encode(copyrights, forKey: SerializationKeys.copyrights)
  }

}
