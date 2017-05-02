//
//  MOOverviewPolyline.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation


public final class MOOverviewPolyline: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let points = "points"
  }

  // MARK: Properties
  public var points: String?

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
    points = json[SerializationKeys.points].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = points { dictionary[SerializationKeys.points] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.points = aDecoder.decodeObject(forKey: SerializationKeys.points) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(points, forKey: SerializationKeys.points)
  }

}
