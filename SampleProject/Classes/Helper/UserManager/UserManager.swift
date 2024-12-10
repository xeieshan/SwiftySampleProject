//
//  UserManager.swift
//  SwiftyUserManager
//
//  Created by <#Project Developer#> on 30/01/2017.
//  Copyright © 2017 <#Project Developer#> All rights reserved.
//
//  https://github.com/xeieshan/SwiftUserManager

import Foundation

public class UserManager {
    
    static let kUserType: String = "user"
    
    static let UserManagerUserToken: String = "UserManagerUserToken"
    
    static var _currentUser: MOProfile?
    
    static var _token: String?
    class public var token:String {
        get {
            return UserDefaults.standard.string(forKey: UserManager.UserManagerUserToken)!
        }
        set {
            UserManager.setToken(token: token)
        }
    }
    
    
    class public var currentUser: MOProfile? {
        set {
            UserManager.setCurrentUser(currentUser)
        }
        get {
            if (_currentUser != nil) {
                return _currentUser!
            }
            let dataCurentUser: NSData! = NSData(contentsOfFile: UserManager.pathWithObjectType(objectType: UserManager.kUserType))
            if (dataCurentUser != nil) {
                _currentUser = NSKeyedUnarchiver.unarchiveObject(with: dataCurentUser as Data) as? MOProfile
                return _currentUser!
            }
            
            return nil
        }
    }
    
    
    init() {
        
    }
    
    // MARK: - User
    
    
    class public func setCurrentUser(_ newCurrentUser: MOProfile?) {
        //        assert(newCurrentUser != nil, "Trying to set current user to nil! Use [UserManager logOutCurrentUser] instead!")
        _currentUser = newCurrentUser
        if newCurrentUser != nil {
            UserManager.saveCurrentUser()
        }
    }
    
    class func saveCurrentUser() {
        if _currentUser == nil {
            assert(_currentUser != nil, "Error! Save current user: currentUser == nil!!")
            return
        }
        let path: String = UserManager.pathWithObjectType(objectType: UserManager.kUserType)
        let filemgr : FileManager = FileManager.default
        
        print ("PATH : \n%@", path)
        do {
            if filemgr.fileExists(atPath: path) {
                try filemgr.removeItem(atPath: path as String)
                print("Deleting previous user entry")
            }
        }
        catch {
            print ("Failed to Delete logged user")
        }
        
        let userData: Data = NSKeyedArchiver.archivedData(withRootObject: _currentUser!) as Data
        
        do{
            try userData.write(to: URL(fileURLWithPath: path), options: .atomic)
        }catch _ {
            debugPrint("Failed to write")
        }
    }
    
    class public func logOutCurrentUser() {
        let path:String = UserManager.pathWithObjectType(objectType: UserManager.kUserType)
        
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("Deleting previous user entry")
            }
            catch {
                print("Failed to Delete user File")
            }
        }
        UserManager.setCurrentUser(nil)
    }
    
    class public func logOutUserAndClearToken() {
        UserManager.logOutCurrentUser()
        UserManager.setCurrentUser(nil)
        UserManager.setToken(token: "")
    }
    
    class public func isLoggedIn() -> Bool {
        if _token != nil {
            return _currentUser != nil && (_token?.count)!>0
        }
        return _currentUser != nil
    }
    
    
    class internal func setToken(token: String) {
        _token = token
        if _token != nil {
            UserDefaults.standard.set(_token, forKey: UserManagerUserToken)
        } else {
            UserDefaults.standard.removeObject(forKey: UserManagerUserToken)
            
        }
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Utility
    class internal func pathWithObjectType(objectType: String) -> String {
        
        //        let fileManager = FileManager.default
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        let finalDatabaseURL = documentsDirectory.appendingPathComponent("\(objectType).bin")
        return finalDatabaseURL
    }
}
