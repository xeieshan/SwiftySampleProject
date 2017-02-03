//
//  ConstanttilsMacros.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//
import UIKit
import Foundation

/** Utils macros **/
// Open URL
//#define OPEN_URL(url)                                           [APPLICATION openURL:(url)]
//#define OPEN_STRING_URL(url)                                    [APPLICATION openURL:[NSURL URLWithString:([url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding])]]
//#define CALL_NUMBER(number)                                     [APPLICATION openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:[number stringByReplacingOccurrencesOfString:@" " withString:@""]]]]
// Files
//let PATH_DOCUMENTS = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
//let PATH_LIBRARY = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true)[0]
//let PATH_PRIVATE_STORAGE = PATH_LIBRARY.stringByAppendingPathComponent("Caches").stringByAppendingPathComponent("PrivateStorage")
//#define PATH_FOR_RESOURCE(file, ext)                            (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext] : nil)
//#define PATH_FOR_RESOURCE_IN_DIRECTORY(file, ext, directory)    (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext inDirectory:directory] : nil)
//let TEMPORARY_FILE_PATH = NSTemporaryDirectory().stringByAppendingPathComponent("\(NSDate.timeIntervalSinceReferenceDate())")
//#define REMOVE_ITEM_AT_PATH(path)                               [FILE_MANAGER removeItemAtPath:path error:nil]
//#define FILE_EXISTS_AT_PATH(path)                               [FILE_MANAGER fileExistsAtPath:path]
// Load a nib
//#define LOAD_NIB_NAMED(nibName)                                 do{[MAIN_BUNDLE loadNibNamed:nibName owner:self options:nil];}while(0)
// User interactions
//let ENABLE_USER_INTERACTIONS = APPLICATION.endIgnoringInteractionEvents()
//let DISABLE_USER_INTERACTIONS = APPLICATION.beginIgnoringInteractionEvents()
// Notifications
//let NOTIFICATION_CENTER_REMOVE = NOTIFICATION_CENTER.removeObserver(self)
// Allow conversion from nil to [NSNull null]
//#define nilToNSNull(value)                                      (value ? value : [NSNull null])
//#define NSNullToNil(value)                                      ((id)value == [NSNull null] ? nil : value)
// Device language override
let APPLICATION_LANGUAGES_KEY = "AppleLanguages"
//#define OVERRIDE_APPLICATION_LANGUAGE(newLang)                  do {[USER_DEFAULTS setObject:[NSArray arrayWithObject:newLang] forKey:APPLICATION_LANGUAGES_KEY]; [USER_DEFAULTS synchronize];} while(0)


