//
//  ConstantShortcuts_All.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//
// Localized string helpers

import UIKit
import Foundation

//let  LOCALIZED_STRING(string) NSLocalizedString(string, nil)
//let LANG = LOCALIZED_STRING("globals.lang")
//let LANG_DISPLAY = LOCALIZED_STRING("globals.langDisplay")
// Shared instance shortcuts
let NOTIFICATION_CENTER = NotificationCenter.default
let FILE_MANAGER = FileManager.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current
let MAIN_RUN_LOOP = RunLoop.main
let GENERAL_PASTEBOARD = UIPasteboard.general
let CURRENT_LANGUAGE = NSLocale.current.languageCode

// Network
let NETWORK_ACTIVITY = APPLICATION.isNetworkActivityIndicatorVisible
// Color consts
let CLEAR_COLOR = UIColor.clear
// Application informations
let APPLICATION_NAME = MAIN_BUNDLE.infoDictionary?[kCFBundleNameKey as String]
let APPLICATION_VERSION = MAIN_BUNDLE.object(forInfoDictionaryKey: "CFBundleVersion")
let IN_SIMULATOR = (TARGET_IPHONE_SIMULATOR != 0)
