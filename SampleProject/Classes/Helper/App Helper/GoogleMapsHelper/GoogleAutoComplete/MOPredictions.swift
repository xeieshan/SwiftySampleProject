//
//  MOPredictions.swift
//
//  Created by <#Project Name#> on 20/03/2017
//  Copyright (c) <#Project Developer#>. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MOPredictions: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reference = "reference"
    static let matchedSubstrings = "matched_substrings"
    static let id = "id"
    static let structuredFormatting = "structured_formatting"
    static let descriptionValue = "description"
    static let placeId = "place_id"
    static let terms = "terms"
    static let types = "types"
  }

  // MARK: Properties
  public var reference: String?
  public var matchedSubstrings: [MOMatchedSubstrings]?
  public var id: String?
  public var structuredFormatting: MOStructuredFormatting?
  public var descriptionValue: String?
  public var placeId: String?
  public var terms: [MOTerms]?
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
    reference = json[SerializationKeys.reference].string
    if let items = json[SerializationKeys.matchedSubstrings].array { matchedSubstrings = items.map { MOMatchedSubstrings(json: $0) } }
    id = json[SerializationKeys.id].string
    structuredFormatting = MOStructuredFormatting(json: json[SerializationKeys.structuredFormatting])
    descriptionValue = json[SerializationKeys.descriptionValue].string
    placeId = json[SerializationKeys.placeId].string
    if let items = json[SerializationKeys.terms].array { terms = items.map { MOTerms(json: $0) } }
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reference { dictionary[SerializationKeys.reference] = value }
    if let value = matchedSubstrings { dictionary[SerializationKeys.matchedSubstrings] = value.map { $0.dictionaryRepresentation() } }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = structuredFormatting { dictionary[SerializationKeys.structuredFormatting] = value.dictionaryRepresentation() }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    if let value = terms { dictionary[SerializationKeys.terms] = value.map { $0.dictionaryRepresentation() } }
    if let value = types { dictionary[SerializationKeys.types] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reference = aDecoder.decodeObject(forKey: SerializationKeys.reference) as? String
    self.matchedSubstrings = aDecoder.decodeObject(forKey: SerializationKeys.matchedSubstrings) as? [MOMatchedSubstrings]
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.structuredFormatting = aDecoder.decodeObject(forKey: SerializationKeys.structuredFormatting) as? MOStructuredFormatting
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
    self.terms = aDecoder.decodeObject(forKey: SerializationKeys.terms) as? [MOTerms]
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reference, forKey: SerializationKeys.reference)
    aCoder.encode(matchedSubstrings, forKey: SerializationKeys.matchedSubstrings)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(structuredFormatting, forKey: SerializationKeys.structuredFormatting)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
    aCoder.encode(terms, forKey: SerializationKeys.terms)
    aCoder.encode(types, forKey: SerializationKeys.types)
  }

}
