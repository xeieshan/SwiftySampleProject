//
//  Constants.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//
import Foundation
import UIKit

@objc class Constants : NSObject {
    //Necessary Macros
    static let SquareDimension:Float = ((ConstantDevices.IS_IPAD) ? 600 : 310)
    static let ViewHeight:Float = ((ConstantDevices.IS_IPAD) ? 130 : 70)
    static let ApplicationDelegate:AppDelegate = ((UIApplication.shared.delegate as! AppDelegate))
    
    // MARK: - Validations
    static let kValidate_Numeric:String  = "0123456789"
    static let kValidate_AlphaNumeric:String  = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    class func getValidate_Numeric() -> String{
        return Constants.kValidate_Numeric
    }
    
    class func getValidate_AlphaNumeric() -> String{
        return Constants.kValidate_AlphaNumeric
    }
    
    class func getApplicationDelegate() ->  AppDelegate{
        return Constants.ApplicationDelegate
    }
}


/*
enums
enum CellIdentifiers: String {
case Blue = "BlueCellIdentifier"
case Large = "LargeCellIdentifier"
}

enum FontSizes: CGFloat {
case Large = 14.0
case Small = 10.0
}

enum AnimationTimes: NSTimeInterval {
case Fast = 1.0
case Medium = 3.0
case Slow = 5.0
}

enum Emojis: Character {
case Happy = "😄"
case Sad = "😢"
}

enum SegueIdentifiers: String {
case Master = "MasterViewController"
case Detail = "DetailViewController"
}

usage
let segueIdentifier = SegueIdentifiers.Master.rawValue
*/

/*
struct
struct CellIdentifiers {
static let Blue = "BlueCellIdentifier"
static let Large = "LargeCellIdentifier"
}

struct FontSizes {
static let Large: CGFloat = 14.0
static let Small: CGFloat = 10.0
}

struct AnimationDurations {
static let Fast: NSTimeInterval = 1.0
static let Medium: NSTimeInterval = 3.0
static let Slow: NSTimeInterval = 5.0
}

struct Emojis {
static let Happy = "😄"
static let Sad = "😢"
}

struct SegueIdentifiers {
static let Master = "MasterViewController"
static let Detail = "DetailViewController"
}

usage
UIView.animateWithDuration(AnimationDurations.Slow) {
aCustomView.alpha = 0.0
}
*/
