//
//  MOSteps.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MOSteps: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startLocation = "start_location"
    static let endLocation = "end_location"
    static let polyline = "polyline"
    static let travelMode = "travel_mode"
    static let distance = "distance"
    static let htmlInstructions = "html_instructions"
    static let maneuver = "maneuver"
    static let duration = "duration"
  }

  // MARK: Properties
  public var startLocation: MOStartLocation?
  public var endLocation: MOEndLocation?
  public var polyline: MOPolyline?
  public var travelMode: String?
  public var distance: MODistance?
  public var htmlInstructions: String?
  public var maneuver: String?
  public var duration: MODuration?

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
    startLocation = MOStartLocation(json: json[SerializationKeys.startLocation])
    endLocation = MOEndLocation(json: json[SerializationKeys.endLocation])
    polyline = MOPolyline(json: json[SerializationKeys.polyline])
    travelMode = json[SerializationKeys.travelMode].string
    distance = MODistance(json: json[SerializationKeys.distance])
    htmlInstructions = json[SerializationKeys.htmlInstructions].string
    maneuver = json[SerializationKeys.maneuver].string
    duration = MODuration(json: json[SerializationKeys.duration])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = endLocation { dictionary[SerializationKeys.endLocation] = value.dictionaryRepresentation() }
    if let value = polyline { dictionary[SerializationKeys.polyline] = value.dictionaryRepresentation() }
    if let value = travelMode { dictionary[SerializationKeys.travelMode] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value.dictionaryRepresentation() }
    if let value = htmlInstructions { dictionary[SerializationKeys.htmlInstructions] = value }
    if let value = maneuver { dictionary[SerializationKeys.maneuver] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? MOStartLocation
    self.endLocation = aDecoder.decodeObject(forKey: SerializationKeys.endLocation) as? MOEndLocation
    self.polyline = aDecoder.decodeObject(forKey: SerializationKeys.polyline) as? MOPolyline
    self.travelMode = aDecoder.decodeObject(forKey: SerializationKeys.travelMode) as? String
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? MODistance
    self.htmlInstructions = aDecoder.decodeObject(forKey: SerializationKeys.htmlInstructions) as? String
    self.maneuver = aDecoder.decodeObject(forKey: SerializationKeys.maneuver) as? String
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? MODuration
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(endLocation, forKey: SerializationKeys.endLocation)
    aCoder.encode(polyline, forKey: SerializationKeys.polyline)
    aCoder.encode(travelMode, forKey: SerializationKeys.travelMode)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(htmlInstructions, forKey: SerializationKeys.htmlInstructions)
    aCoder.encode(maneuver, forKey: SerializationKeys.maneuver)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
  }

}
