//
//  SPAppHelper.swift
//  SwiftyUserManager
//
//  Created by <#Project Developer#> on 30/01/2017.
//  Copyright © 2017 <#Project Developer#> All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#endif

// MARK: - Global variables

#if os(iOS)
    /// Get AppDelegate. To use it, cast to AppDelegate with "as! AppDelegate".
    public let appDelegate: UIApplicationDelegate? = UIApplication.shared.delegate

    // MARK: - Global functions

    /// NSLocalizedString without comment parameter.
    ///
    /// - Parameter key: The key of the localized string.
    /// - Returns: Returns a localized string.
    public func NSLocalizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
#endif

public enum SPAppHelperError: Error {
    case jsonSerialization
    case errorLoadingSound
    case pathNotExist
    case pathNotAllowed
}


// MARK: - SPAppHelper struct

/// This class adds some useful functions for the App.
public struct SPAppHelper {
    // MARK: - Variables
    
    /// Used to store the BFHasBeenOpened in defaults.
    private static let SPAppHelperHasBeenOpened = "SPAppHelperHasBeenOpened"
    
    // MARK: - Functions
    
    /// Executes a block only if in DEBUG mode.
    ///
    /// More info on how to use it [here](http://stackoverflow.com/questions/26890537/disabling-nslog-for-production-in-swift-project/26891797#26891797).
    ///
    /// - Parameter block: The block to be executed.
    public static func debug(_ block: () -> Void) {
        #if DEBUG
            block()
        #endif
    }

    /// Executes a block only if NOT in DEBUG mode.
    ///
    /// More info on how to use it [here](http://stackoverflow.com/questions/26890537/disabling-nslog-for-production-in-swift-project/26891797#26891797).
    ///
    /// - Parameter block: The block to be executed.
    public static func release(_ block: () -> Void) {
        #if !DEBUG
            block()
        #endif
    }
    
    /// If version is set returns if is first start for that version,
    /// otherwise returns if is first start of the App.
    ///
    /// - Parameter version: Version to be checked, you can use the variable SPAppHelper.version to pass the current App version.
    /// - Returns: Returns if is first start of the App or for custom version.
    public static func isFirstStart(version: String = "") -> Bool {
        let key: String
        if version == "" {
            key = SPAppHelperHasBeenOpened
        } else {
            key = SPAppHelperHasBeenOpened + "\(version)"
        }
        
        let defaults = UserDefaults.standard
        let hasBeenOpened: Bool = defaults.bool(forKey: key)
        
        return !hasBeenOpened
    }
    
    /// Executes a block on first start of the App, if version is set it will be for given version.
    ///
    /// Remember to execute UI instuctions on main thread.
    ///
    /// - Parameters:
    ///   - version: Version to be checked, you can use the variable SPAppHelper.version to pass the current App version.
    ///   - block: The block to execute, returns isFirstStart.
    public static func onFirstStart(version: String = "", block: (_ isFirstStart: Bool) -> Void) {
        let key: String
        if version == "" {
            key = SPAppHelperHasBeenOpened
        } else {
            key = SPAppHelperHasBeenOpened + "\(version)"
        }
        
        let defaults = UserDefaults.standard
        let hasBeenOpened: Bool = defaults.bool(forKey: key)
        if hasBeenOpened != true {
            defaults.set(true, forKey: key)
        }
        
        block(!hasBeenOpened)
    }
    
    #if os(iOS)
        /// Set the App setting for a given object and key. The file will be saved in the Library directory.
        ///
        /// - Parameters:
        ///   - object: Object to set.
        ///   - objectKey: Key to set the object.
        /// - Returns: Returns true if the operation was successful, otherwise false.
        @discardableResult
        public static func setAppSetting(object: Any, forKey objectKey: String) -> Bool {
            return FileManager.default.setSettings(filename: SPAppHelper.name, object: object, forKey: objectKey)
        }
        
        /// Get the App setting for a given key.
        ///
        /// - Parameter objectKey: Key to get the object.
        /// - Returns: Returns the object for the given key.
        public static func getAppSetting(objectKey: String) -> Any? {
            return FileManager.default.getSettings(filename: SPAppHelper.name, forKey: objectKey)
        }
    #endif
}

// MARK: - SPAppHelper extension

/// Extends SPAppHelper with project infos.
public extension SPAppHelper {
    // MARK: - Variables
    
    /// Return the App name.
    public static var name: String = {
        return SPAppHelper.stringFromInfoDictionary(forKey: "CFBundleDisplayName")
    }()
    
    /// Returns the App version.
    public static var version: String = {
        return SPAppHelper.stringFromInfoDictionary(forKey: "CFBundleShortVersionString")
    }()
    
    /// Returns the App build.
    public static var build: String = {
        return SPAppHelper.stringFromInfoDictionary(forKey: "CFBundleVersion")
    }()
    
    /// Returns the App executable.
    public static var executable: String = {
        return SPAppHelper.stringFromInfoDictionary(forKey: "CFBundleExecutable")
    }()
    
    /// Returns the App bundle.
    public static var bundle: String = {
        return SPAppHelper.stringFromInfoDictionary(forKey: "CFBundleIdentifier")
    }()
    
    // MARK: - Functions
    
    /// Returns a String from the Info dictionary of the App.
    ///
    /// - Parameter key: Key to search.
    /// - Returns: Returns a String from the Info dictionary of the App.
    private static func stringFromInfoDictionary(forKey key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[key] as? String else {
            return ""
        }
        
        return value
    }
}

extension FileManager {
    
    /// Path type enum.
    ///
    /// - mainBundle: Main bundle path.
    /// - library: Library path.
    /// - documents: Documents path.
    /// - cache: Cache path.
    public enum PathType: Int {
        case mainBundle
        case library
        case documents
        case cache
        case applicationSupport
    }
    
    // MARK: - Functions
    
    /// Get the path for a PathType.
    ///
    /// - Parameter path: Path type.
    /// - Returns: Returns the path type String.
    public func pathFor(_ path: PathType) -> String? {
        var pathString: String?
        
        switch path {
        case .mainBundle:
            pathString = self.mainBundlePath()
        case .library:
            pathString = self.libraryPath()
        case .documents:
            pathString = self.documentsPath()
        case .cache:
            pathString = self.cachePath()
        case .applicationSupport:
            pathString = self.applicationSupportPath()
        }
        
        return pathString
    }
    
    /// Get Main Bundle path for a filename.
    ///
    /// - Parameter file: Filename
    /// - Returns: Returns the path as a String.
    public func mainBundlePath(file: String = "") -> String? {
        return Bundle.main.path(forResource: file.deletingPathExtension, ofType: file.pathExtension)
    }
    
    /// Get Documents path for a filename.
    ///
    /// - Parameter file: Filename
    /// - Returns: Returns the path as a String.
    public func documentsPath(file: String = "") -> String? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsURL.path.appendingPathComponent(file)
    }
    
    /// Get Library path for a filename.
    ///
    /// - Parameter file: Filename
    /// - Returns: Returns the path as a String.
    public func libraryPath(file: String = "") -> String? {
        guard let libraryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return nil
        }
        return libraryURL.path.appendingPathComponent(file)
    }
    
    /// Get Cache path for a filename.
    ///
    /// - Parameter file: Filename
    /// - Returns: Returns the path as a String.
    public func cachePath(file: String = "") -> String? {
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return cacheURL.path.appendingPathComponent(file)
    }
    
    /// Get Application Support path for a filename.
    ///
    /// - Parameter file: Filename
    /// - Returns: Returns the path as a String.
    public func applicationSupportPath(file: String = "") -> String? {
        guard let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return nil
        }
        return applicationSupportURL.path.appendingPathComponent(file)
    }
    
    
    /// Set settings for object and key. The file will be saved in the Library path if not exist.
    ///
    /// - Parameters:
    ///   - filename: Settings filename. "-Settings" will be automatically added.
    ///   - object: Object to set.
    ///   - objKey: Object key.
    /// - Returns: Returns true if the operation was successful, otherwise false.
    /// - Throws: Throws SPAppHelperError errors.
    @discardableResult
    public func setSettings(filename: String, object: Any, forKey objKey: String) -> Bool {
        guard var path = FileManager.default.pathFor(.applicationSupport) else {
            return false
        }
        path = path.appendingPathComponent("\(filename)-Settings.plist")
        
        var loadedPlist: NSMutableDictionary
        if FileManager.default.fileExists(atPath: path) {
            loadedPlist = NSMutableDictionary(contentsOfFile: path)!
        } else {
            loadedPlist = NSMutableDictionary()
        }
        
        loadedPlist[objKey] = object
        
        return loadedPlist.write(toFile: path, atomically: true)
    }
    /// Get settings for key.
    ///
    /// - Parameters:
    ///   - filename: Settings filename. "-Settings" will be automatically added.
    ///   - forKey: Object key.
    /// - Returns: Returns the object for the given key.
    public func getSettings(filename: String, forKey: String) -> Any? {
        guard var path = FileManager.default.pathFor(.applicationSupport) else {
            return nil
        }
        path = path.appendingPathComponent("\(filename)-Settings.plist")
        
        var loadedPlist: NSMutableDictionary
        if FileManager.default.fileExists(atPath: path) {
            loadedPlist = NSMutableDictionary(contentsOfFile: path)!
        } else {
            return nil
        }
        
        return loadedPlist.object(forKey: forKey)
    }
}
/*
 Usage 
 
 SPAppHelper.onFirstStart { isFirstStart in
 if isFirstStart {
 debugPrint("Is first start!")
 } else {
 debugPrint("Is not first start!")
 }
 }
 
 */
