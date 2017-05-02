//
//  MOLegs.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MOLegs: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startLocation = "start_location"
    static let endAddress = "end_address"
    static let endLocation = "end_location"
    static let startAddress = "start_address"
    static let steps = "steps"
    static let distance = "distance"
    static let trafficSpeedEntry = "traffic_speed_entry"
    static let duration = "duration"
    static let viaWaypoint = "via_waypoint"
  }

  // MARK: Properties
  public var startLocation: MOStartLocation?
  public var endAddress: String?
  public var endLocation: MOEndLocation?
  public var startAddress: String?
  public var steps: [MOSteps]?
  public var distance: MODistance?
  public var trafficSpeedEntry: [Any]?
  public var duration: MODuration?
  public var viaWaypoint: [Any]?

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
    endAddress = json[SerializationKeys.endAddress].string
    endLocation = MOEndLocation(json: json[SerializationKeys.endLocation])
    startAddress = json[SerializationKeys.startAddress].string
    if let items = json[SerializationKeys.steps].array { steps = items.map { MOSteps(json: $0) } }
    distance = MODistance(json: json[SerializationKeys.distance])
    if let items = json[SerializationKeys.trafficSpeedEntry].array { trafficSpeedEntry = items.map { $0.object} }
    duration = MODuration(json: json[SerializationKeys.duration])
    if let items = json[SerializationKeys.viaWaypoint].array { viaWaypoint = items.map { $0.object} }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = endAddress { dictionary[SerializationKeys.endAddress] = value }
    if let value = endLocation { dictionary[SerializationKeys.endLocation] = value.dictionaryRepresentation() }
    if let value = startAddress { dictionary[SerializationKeys.startAddress] = value }
    if let value = steps { dictionary[SerializationKeys.steps] = value.map { $0.dictionaryRepresentation() } }
    if let value = distance { dictionary[SerializationKeys.distance] = value.dictionaryRepresentation() }
    if let value = trafficSpeedEntry { dictionary[SerializationKeys.trafficSpeedEntry] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value.dictionaryRepresentation() }
    if let value = viaWaypoint { dictionary[SerializationKeys.viaWaypoint] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? MOStartLocation
    self.endAddress = aDecoder.decodeObject(forKey: SerializationKeys.endAddress) as? String
    self.endLocation = aDecoder.decodeObject(forKey: SerializationKeys.endLocation) as? MOEndLocation
    self.startAddress = aDecoder.decodeObject(forKey: SerializationKeys.startAddress) as? String
    self.steps = aDecoder.decodeObject(forKey: SerializationKeys.steps) as? [MOSteps]
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? MODistance
    self.trafficSpeedEntry = aDecoder.decodeObject(forKey: SerializationKeys.trafficSpeedEntry) as? [Any]
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? MODuration
    self.viaWaypoint = aDecoder.decodeObject(forKey: SerializationKeys.viaWaypoint) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(endAddress, forKey: SerializationKeys.endAddress)
    aCoder.encode(endLocation, forKey: SerializationKeys.endLocation)
    aCoder.encode(startAddress, forKey: SerializationKeys.startAddress)
    aCoder.encode(steps, forKey: SerializationKeys.steps)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(trafficSpeedEntry, forKey: SerializationKeys.trafficSpeedEntry)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
    aCoder.encode(viaWaypoint, forKey: SerializationKeys.viaWaypoint)
  }

}
