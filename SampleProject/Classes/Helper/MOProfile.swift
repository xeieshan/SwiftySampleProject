//
//  MOProfile.swift
//  SwiftyUserManager
//
//  Created by <#Project Developer#> on 30/01/2017.
//  Copyright © 2017 <#Project Developer#> All rights reserved.
//

import Foundation


public final class MOProfile: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let email = "email"
    static let id = "id"
    static let lastName = "lastName"
    static let userName = "userName"
    static let firstName = "firstName"
    
  }

  // MARK: Properties
  public var email: String?
  public var id: Int?
  public var lastName: String?
  public var userName: String?
  public var firstName: String?

    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    //
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        email = dictionary[SerializationKeys.email] as? String
        id = dictionary[SerializationKeys.id] as? Int
        lastName = dictionary[SerializationKeys.lastName] as? String
        firstName = dictionary[SerializationKeys.firstName] as? String
        userName = dictionary[SerializationKeys.userName] as? String
    }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
    
    self.userName = aDecoder.decodeObject(forKey: SerializationKeys.userName) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String

  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(lastName, forKey: SerializationKeys.lastName)
    aCoder.encode(userName, forKey: SerializationKeys.userName)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)

  }

}
