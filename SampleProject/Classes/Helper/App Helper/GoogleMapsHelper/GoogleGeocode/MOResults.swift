//
//  MOResults.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOResults: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let geometry = "geometry"
    static let formattedAddress = "formatted_address"
    static let types = "types"
    static let addressComponents = "address_components"
    static let placeId = "place_id"
  }

  // MARK: Properties
  public var geometry: MOGeometry?
  public var formattedAddress: String?
  public var types: [String]?
  public var addressComponents: [MOAddressComponents]?
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
    geometry = MOGeometry(json: json[SerializationKeys.geometry])
    formattedAddress = json[SerializationKeys.formattedAddress].string
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
    if let items = json[SerializationKeys.addressComponents].array { addressComponents = items.map { MOAddressComponents(json: $0) } }
    placeId = json[SerializationKeys.placeId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = geometry { dictionary[SerializationKeys.geometry] = value.dictionaryRepresentation() }
    if let value = formattedAddress { dictionary[SerializationKeys.formattedAddress] = value }
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = addressComponents { dictionary[SerializationKeys.addressComponents] = value.map { $0.dictionaryRepresentation() } }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.geometry = aDecoder.decodeObject(forKey: SerializationKeys.geometry) as? MOGeometry
    self.formattedAddress = aDecoder.decodeObject(forKey: SerializationKeys.formattedAddress) as? String
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.addressComponents = aDecoder.decodeObject(forKey: SerializationKeys.addressComponents) as? [MOAddressComponents]
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(geometry, forKey: SerializationKeys.geometry)
    aCoder.encode(formattedAddress, forKey: SerializationKeys.formattedAddress)
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(addressComponents, forKey: SerializationKeys.addressComponents)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
  }

}
