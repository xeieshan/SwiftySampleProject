//
//  UtilityHelper.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 01/03/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import SystemConfiguration
import AVFoundation
import MobileCoreServices

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif
/**
 A wrapper around GCD queues. This shouldn't be accessed directly, but rather through
 the helper functions supplied by the APSwiftHelpers package.
 */

// Swift 3.0 Help from https://swiftable.io/2016/06/dispatch-queues-swift-3/
public enum QueueType {
    case Main
    case Background
    case LowPriority
    case HighPriority
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return DispatchQueue.main
        case .Background:
            return DispatchQueue(label: "com.app.queue",
                                 qos: .background,
                                 target: nil)
        case .LowPriority:
            return DispatchQueue.global(qos: .userInitiated)
        case .HighPriority:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
}

class UtilityHelper
{
    
    class func shouldChangeCharactersForAllowedCharacters(textField: UITextField, range: NSRange, replacementString string: String, allowedCharacters: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return prospectiveText.containsOnlyCharactersIn(allowedCharacters)
    }
    
    class func getTopMostViewController() -> UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            // topController should now be your topmost view controller
            return topController
        }
        return UIViewController()
    }
    class func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    // MARK: - UIAlertViewController (called from UIViewController)
    
    /**
     * Usage: Helpers.showOKAlert("Alert", message: "Something happened", target: self)
     */
    static func showOKAlert(_ title: String, message: String, target: UIViewController)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Usage: Helpers.showOKHelpAlert("Notice", message: "Something happened.", target: self, handler: { (UIAlertAction) -> Void in
     *          // perform help option code here
     *     })
     */
    static func showOKHelpAlert(_ title: String, message: String, target: UIViewController, handler: ((UIAlertAction) -> Void)?)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let helpAction: UIAlertAction = UIAlertAction(title: "Help", style: .default, handler: handler)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(helpAction)
        alertController.addAction(okAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Usage: Helpers.showContinueAlert("Log Out", message: "Are you sure you want to log out?", target: self, handler: { (UIAlertAction) -> Void in
     *          // perform log out code here
     *     })
     */
    static func showContinueAlert(_ title: String, message: String, target: UIViewController, handler: ((UIAlertAction) -> Void)?)
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueAction: UIAlertAction = UIAlertAction(title: "Continue", style: .default, handler: handler)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIActionSheet (TODO)
    
    // MARK: - Localization
    
    static func getFormattedStringFromNumber(_ number: Double) -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value : number))!
    }
    
    static func getFormattedStringFromDate(_ aDate: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: aDate)
    }
    
    // MARK: - Set Up Application UI Appearance
    class func setupApplicationUIAppearance() {
//        UILabel.appearance().setSubstituteFontName(UIConfiguration.UIFONTAPP)
        UILabel.appearance().defaultFont = UIFont(name: UIConfiguration.UIFONTAPP, size: 15)
        
            UITabBarItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.font : UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 17)
                ], for: UIControlState())
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIConfiguration.getUIFONTBOLD(sizeFont: 17)]
        
        if #available(iOS 9.0, *) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.font : UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16)
                ], for: UIControlState())
        } else {
            // Fallback on earlier versions
        }
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIConfiguration.getUIFONTAPPREGULAR(sizeFont: 16)], for: .normal)
        
        let rect:CGRect! = CGRect(x: 0 ,y: 0, width: Constants.getApplicationDelegate().window!.frame.size.width, height: 64)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIConfiguration.MainNavBackColor.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UINavigationBar.appearance().setBackgroundImage(image, for: UIBarMetrics.default)
        
    }
    // MARK: - Validations
    
    class func isValidEmailAddress(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func isValidateNumber(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_Numeric())
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateSaudiaNumber(_ checkString: NSString) -> Bool {
        //+966126123100
        //http://regexlib.com/Search.aspx?k=saudi&c=-1&m=-1&ps=20
        //https://gist.github.com/homaily/8672499
        //https://regex101.com
        let numcharacters: CharacterSet = CharacterSet(charactersIn: "^(009665|9665|+9665|05|+966)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateAlphabet(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateAlphabetWithWhiteSpace(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        var characterCount: Int32 = 0
        //        var i: Int
        
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidStringNumericPlus(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: "0123456789+")
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    // MARK: - Get Preferred Language
    
    class func getPrefferedLanguage() -> String {
        for languageItem in Locale.preferredLanguages {
            if languageItem == "en" || languageItem == "ru" || languageItem == "uk" || languageItem == "de" || languageItem == "fr" || languageItem == "it" || languageItem == "es" || languageItem == "ar" {
                return languageItem
            }
        }
        return "en"
    }
    // MARK: - Dynamic Heights
    
    class func getTextDymanicHeightOfStringWithText(_ text: NSString, andFont font: UIFont, andFrame frame: CGRect) -> CGFloat {
        let maxSize: CGSize = CGSize(width: frame.size.width, height: 999999.0)
        var height: CGFloat = 0
        
        let frame1: CGRect = text.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        height = frame1.size.height
        return height+5
    }
    
    class func getLabelDymanicHeight(_ label: UILabel) -> CGFloat {
        let maxSize: CGSize = CGSize(width: label.frame.size.width, height: 999999.0)
        var height: CGFloat = 0
        let font: UIFont = label.font
        
        let frame: CGRect = label.text!.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        height = frame.size.height
        label.numberOfLines = 0
        return height+5
    }
    
    class func getStringHeightWithConstrainedWidth(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        
        return boundingBox.height
    }
    
    class func getAttributedStringHeightWithConstrainedWidth(_ attributedText: NSAttributedString, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = attributedText.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    class func getAttributedStringWidthWithConstrainedHeight(_ attributedText: NSAttributedString, height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = attributedText.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
    // MARK: - Date Conversions
    
    class func convertStringDate(_ date: String, formatFrom: String, formatTo: String) -> String {
        let dateString: String = date
        let dateFormatter: DateFormatter = DateFormatter()
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        dateFormatter.dateFormat = formatFrom
        var dateFromString: Date
        dateFromString = dateFormatter.date(from: dateString)!
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = formatTo
        //Optionally for time zone converstions
        formatter.timeZone = TimeZone(identifier: "...")
        let birthday: String = formatter.string(from: dateFromString)
        return birthday
    }
    
    class func convertDateToString(_ date: Date, withFormat Format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = Format
        let stringFromDate: String = formatter.string(from: date)
        return stringFromDate
    }
    
    class func convertStringToDate(_ date: String, formatFrom: String) -> Date {
        let myFormatter: DateFormatter = DateFormatter()
        myFormatter.timeZone = TimeZone.current
        //    [myFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:@"Gregorion"]];
        myFormatter.dateFormat = formatFrom
        let myDate: Date = myFormatter.date(from: date)!
        return myDate
    }
    
    // MARK: - UIView Related
    
    class func setViewBorder(_ yourView: UIView, withWidth borderWidth: CGFloat, andColor borderColor: UIColor, cornerRadius radius: CGFloat, andShadowColor shadowColor: UIColor, shadowRadius: CGFloat) {
        // border radius
        yourView.layer.cornerRadius = radius
        // border
        yourView.layer.borderColor = borderColor.cgColor
        yourView.layer.borderWidth = borderWidth
        // drop shadow
        yourView.layer.shadowColor = shadowColor.cgColor
        yourView.layer.shadowOpacity = 0.8
        yourView.layer.shadowRadius = shadowRadius
        yourView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    class func setViewBorder(_ view: UIView, withWidth width: CGFloat, andColor color: UIColor) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
    }
    
    class func setViewCornerRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    static func compressImage(_ image:UIImage) -> Data {
        // Reducing file size to a 10th
        
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let maxHeight : CGFloat = 1136.0
        let maxWidth : CGFloat = 640.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        var compressionQuality : CGFloat = 0.5
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
                compressionQuality = 1;
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight);
        UIGraphicsBeginImageContext(rect.size);
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        let imageData = UIImageJPEGRepresentation(img!, compressionQuality);
        UIGraphicsEndImageContext();
        
        return imageData!;
    }
    
    static func compressVideo(_ inputURL: URL, outputURL: URL, handler:@escaping (_ session: AVAssetExportSession)-> Void)
    {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        
        let exportSession = AVAssetExportSession(asset: urlAsset, presetName:AVAssetExportPresetLowQuality)
        //AVAssetExportPresetMediumQuality, AVAssetExportPresetLowQuality, AVAssetExportPreset640x480
        
        exportSession!.outputURL = outputURL
        
        exportSession!.outputFileType = AVFileType.mp4 //AVFileTypeMPEG4, AVFileTypeQuickTimeMovie
        
        exportSession!.shouldOptimizeForNetworkUse = true
        
        exportSession!.exportAsynchronously { () -> Void in
            
            handler(exportSession!)
        }
    }
    
    static func MIMEType(fileExtension: String) -> String? {
        if !fileExtension.isEmpty {
            let UTIRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as CFString, nil)
            let UTI = UTIRef?.takeUnretainedValue()
            UTIRef?.release()
            
            let MIMETypeRef = UTTypeCopyPreferredTagWithClass(UTI!, kUTTagClassMIMEType)
            if MIMETypeRef != nil
            {
                let MIMEType = MIMETypeRef?.takeUnretainedValue()
                MIMETypeRef?.release()
                return MIMEType as String?
            }
        }
        return nil
    }
    
    class func setViewBorderBottom(_ view: UIView, withWidth width: CGFloat, andColor color: UIColor) {
        view.layoutIfNeeded()
        let bottomBorder: CALayer = CALayer.init()
        bottomBorder.frame = CGRect(x: 0.0, y: view.frame.size.height-0.5, width: view.frame.size.width, height: 0.5)
        bottomBorder.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomBorder)
        view.clipsToBounds = true
    }
    
    class func setViewBorderBottom(_ view: UIView, withWidth width: CGFloat, atDistanceFromBottom bottonY: CGFloat, andColor color: UIColor, clipToBounds: Bool) {
        view.layoutIfNeeded()
        let bottomBorder: CALayer = CALayer.init()
        /*
         UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, view.frame.size.height-bottonY, view.frame.size.width, width)];
         bottomBorder.backgroundColor = color;
         [view addSubview:bottomBorder];
         */
        bottomBorder.frame = CGRect(x: 0.0, y: view.frame.size.height-bottonY, width: view.frame.size.width, height: width)
        bottomBorder.backgroundColor = color.cgColor
        view.layer.addSublayer(bottomBorder)
        view.clipsToBounds = clipToBounds
    }
    
    class func setDropShadowOnView(_ view: UIView, shadowOffset: CGSize) {
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.7
        let shadowPath: CGPath = UIBezierPath(rect: view.layer.bounds).cgPath
        view.layer.shadowPath = shadowPath
    }
    
    class func setDropShadowOnTextField(_ view: UITextField, shadowOffset: CGSize) {
        view.borderStyle = UITextBorderStyle.none
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.5
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 4
        let shadowPath: UIBezierPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 3)
        view.layer.shadowPath = shadowPath.cgPath
    }
    // MARK: - Application Badge
    
    class func setApplicationBadgeNumber(_ number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
    class func increaseApplicationBadgeNumberByOne() {
        let count: Int = UIApplication.shared.applicationIconBadgeNumber
        UIApplication.shared.applicationIconBadgeNumber = count+1
    }
    
    // MARK: -
    // MARK: Session Save
    // MARK: -
    
    class func saveSessionToDisk(_ Session: NSDictionary) {
        let dictionary: NSMutableDictionary = NSMutableDictionary(dictionary: Session)
        let archiveData: Data = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [AnyObject]
        let documentsDir: NSString = paths[0] as! String as NSString
        let fullPath: NSString = documentsDir.appendingPathComponent("SavedSession.plist") as NSString
        try? archiveData.write(to: URL(fileURLWithPath: fullPath as String), options: [.atomic])
    }
    
    class func loadSessionFromDisk() -> NSDictionary? {
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [AnyObject]
        let documentsDir: NSString = paths[0] as! NSString
        let fullPath: String = documentsDir.appendingPathComponent("SavedSession.plist")
        print("\(fullPath)")
        let fileManager: FileManager = FileManager.default
        if fileManager.fileExists(atPath: fullPath) {
            var dict: NSDictionary? = nil
            let archiveData: Data = try! Data(contentsOf: URL(fileURLWithPath: fullPath))
            dict = (NSKeyedUnarchiver.unarchiveObject(with: archiveData) as? NSMutableDictionary)
            return dict
        }
        return nil
    }
    
    // MARK: - Key Window
    class func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    class func getAppWindow() -> UIWindow? {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        return ad.window
    }
    
    // MARK: - Array Form / Dictionary Form
    
    /*
     class MyClass {
     var property1 = 1
     var property2 = "Hi"
     }
     ArrayForm((0, 1, 2, 3))                 // [0, 1, 2, 3]
     ArrayForm(MyClass())                    // [1, "Hi"]
     */
    
    class func ArrayForm(_ value: Any) -> [Any] {
        var mirror: Mirror? = Mirror(reflecting: value)
        var propertyValues = [Any]()
        
        while let currentMirror = mirror {
            propertyValues += currentMirror.children.map { $0.value }
            
            // Get superclass if it exists
            mirror = currentMirror.superclassMirror
        }
        
        return propertyValues
    }
    
    
    /*
     class MyClass {
     var property1 = 1
     var property2 = "Hi"
     }
     DictionaryForm(MyClass())               // ["property1" : 1, "property2" : "Hi"]
     */
    
    class func DictionaryForm(_ value: Any) -> [String : Any] {
        var mirror: Mirror? = Mirror(reflecting: value)
        var objectDictionary = [String : Any]()
        
        while let currentMirror = mirror {
            for (propertyName, value) in currentMirror.children {
                if let key = propertyName { objectDictionary[key] = value }
            }
            
            // Get superclass if it exists
            mirror = currentMirror.superclassMirror
        }
        
        return objectDictionary
    }
    
    // MARK: - Measure height/width from String
    class func measureWidthForText(_ text:NSString?,font:UIFont)->CGFloat{
        if text != nil{
            let tmpLabel = UILabel(frame: CGRect.zero)
            tmpLabel.font = font
            tmpLabel.text = text as String!
            let size = tmpLabel.intrinsicContentSize.width
            return size
        }
        return 0
    }
    
    class func measureHeightForText(_ text:String,font:UIFont)->CGFloat{
        let tmpLabel = UILabel(frame: CGRect.zero)
        tmpLabel.font = font
        tmpLabel.text = text as String
        let size = tmpLabel.intrinsicContentSize.height
        return size
    }
    
    class func requiredHeightForLabelWith(_ width:CGFloat, font:UIFont, text:String) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    //    class func maxFontSizeForLabel(text:String,labelWidth:CGFloat,labelHeight:CGFloat, font:UIFont)->CGFloat{
    //        var fontSize = font.pointSize
    //        var currentHeight = requiredHeightForLabelWith(labelWidth, font: font, text: text)
    //        while currentHeight >= labelHeight{
    //            fontSize = fontSize - 1
    //            font = font.fontWithSize(fontSize)
    //            currentHeight = requiredHeightForLabelWith(labelWidth, font: font, text: text)
    //        }
    //        return fontSize
    //    }
    
    // MARK: - GCD
    /**
     Perform a block on the specified queue. This is just a nicer wrapper around the dispatch_async()
     Grand Central Dispatch function.
     - Parameter queueType:  The queue to execute the block on
     - Parameter closure:    The block to execute
     *Example usage:*
     ```
     performOn(.Main) { self.tableView.reloadData() }
     ```
     */
    class func performOn(_ queueType: QueueType, closure: @escaping () -> Void) {
        queueType.queue.async(execute: closure)
    }
    
    /**
     Perform a block on a queue after waiting the specified time.
     - Parameter delay:     Time to wait in seconds before performing the block
     - Parameter queueType: Queue to execute the block on (default is the main queue)
     - Parameter closure:   Block to execute after the time specified in delay has passed
     *Example usage:*
     ```
     // Wait for 200ms then run the block on the main queue
     delay(0.2) { alert.hide() }
     // Wait for 1s then run the block on a background queue
     delay(1.0, queueType: .Background) { alert.hide() }
     ```
     */
    class func delay(_ delay: TimeInterval, queueType: QueueType = .Main, closure: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queueType.queue.asyncAfter(deadline: time, execute: closure)
    }
    
    
    // MARK: - Mail
    /**
     Open Mail app Compose view
     
     - parameter email:   an email address
     - parameter subject: a subject
     - parameter body:    a body
     */
    class func openMailApp(_ email:String, subject:String, body:String) {
        let toEmail = email
        let toSubject = subject
        let toBody = body
        
        if let
            urlString = ("mailto:\(toEmail)?subject=\(toSubject)&body=\(toBody)").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let _ = URL(string:urlString) {
//            UIApplication.shared.openURL(url)
        }
    }
    
    
    /// App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    
    /// App's bundle ID (if applicable).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    #if os(iOS)
    /// StatusBar height
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    #endif
    
    /// App current build number (if applicable).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    #if os(iOS) || os(tvOS)
    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    #endif
    
    /// App's current version (if applicable).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    #if os(iOS)
    /// Current battery level.
    public static var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    /// Shared instance of current device.
    public static var currentDevice: UIDevice {
        return UIDevice.current
    }
    #elseif os(watchOS)
    /// Shared instance of current device.
    public static var currentDevice: WKInterfaceDevice {
    return WKInterfaceDevice.current()
    }
    #endif
    
    /// Screen height.
    public static var screenHeight: CGFloat {
        #if os(iOS) || os(tvOS)
            return UIScreen.main.bounds.height
        #elseif os(watchOS)
            return currentDevice.screenBounds.height
        #endif
    }
    
    /// Current device model.
    public static var deviceModel: String {
        return currentDevice.model
    }
    
    /// Current device name.
    public static var deviceName: String {
        return currentDevice.name
    }
    
    #if os(iOS)
    /// Current orientation of device.
    public static var deviceOrientation: UIDeviceOrientation {
        return currentDevice.orientation
    }
    #endif
    
    /// Screen width.
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
            return UIScreen.main.bounds.width
        #elseif os(watchOS)
            return currentDevice.screenBounds.width
        #endif
    }
    
    /// Check if app is running in debug mode.
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// Check if app is running in TestFlight mode.
    public static var isInTestFlight: Bool {
        // http://stackoverflow.com/questions/12431994/detect-testflight
        guard let path = Bundle.main.appStoreReceiptURL?.path else {
            return false
        }
        return path.contains("sandboxReceipt")
    }
    
    #if os(iOS)
    /// Check if multitasking is supported in current device.
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    #endif
    
    #if os(iOS)
    /// Current status bar network activity indicator state.
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    #endif
    
    #if os(iOS)
    /// Check if device is iPad.
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    #endif
    
    #if os(iOS)
    /// Check if device is iPhone.
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    #endif
    
    /// Check if application is running on simulator (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            return true
        #else
            return false
        #endif
    }
    
    #if os(iOS)
    /// Status bar visibility state.
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    /// Key window (read only, if applicable).
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    /// Most top view controller (if applicable).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    #endif
    
    #if os(iOS) || os(tvOS)
    /// Shared instance UIApplication.
    public static var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    #endif
    
    #if os(iOS)
    /// Current status bar style (if applicable).
    public static var statusBarStyle: UIStatusBarStyle? {
        get {
            return UIApplication.shared.statusBarStyle
        }
        set {
            if let style = newValue {
                UIApplication.shared.statusBarStyle = style
            }
        }
    }
    #endif
    
    /// System current version (read-only).
    public static var systemVersion: String {
        return currentDevice.systemVersion
    }
    
    /// Shared instance of standard UserDefaults (read-only).
    public static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
}
// MARK: - Methods
extension UtilityHelper {
    
    #if os(iOS) || os(tvOS)
    /// Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    public static func didTakeScreenShot(_ action: @escaping () -> ()) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
            action()
        }
    }
    #endif
    
    /// Object from UserDefaults.
    ///
    /// - Parameter forKey: key to find object for.
    /// - Returns: Any object for key (if exists).
    public static func object(forKey: String) -> Any? {
        return UserDefaults.standard.object(forKey: forKey)
    }
    
    /// String from UserDefaults.
    ///
    /// - Parameter forKey: key to find string for.
    /// - Returns: String object for key (if exists).
    public static func string(forKey: String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    /// Integer from UserDefaults.
    ///
    /// - Parameter forKey: key to find integer for.
    /// - Returns: Int number for key (if exists).
    public static func integer(forKey: String) -> Int? {
        return UserDefaults.standard.integer(forKey: forKey)
    }
    
    /// Double from UserDefaults.
    ///
    /// - Parameter forKey: key to find double for.
    /// - Returns: Double number for key (if exists).
    public static func double(forKey: String) -> Double? {
        return UserDefaults.standard.double(forKey: forKey)
    }
    
    /// Data from UserDefaults.
    ///
    /// - Parameter forKey: key to find data for.
    /// - Returns: Data object for key (if exists).
    public static func data(forKey: String) -> Data? {
        return UserDefaults.standard.data(forKey: forKey)
    }
    
    /// Bool from UserDefaults.
    ///
    /// - Parameter forKey: key to find bool for.
    /// - Returns: Bool object for key (if exists).
    public static func bool(forKey: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    /// Array from UserDefaults.
    ///
    /// - Parameter forKey: key to find array for.
    /// - Returns: Array of Any objects for key (if exists).
    public static func array(forKey: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: forKey)
    }
    
    /// Dictionary from UserDefaults.
    ///
    /// - Parameter forKey: key to find dictionary for.
    /// - Returns: ictionary of [String: Any] for key (if exists).
    public static func dictionary(forKey: String) -> [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: forKey)
    }
    
    /// Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float number for key (if exists).
    public static func float(forKey: String) -> Float? {
        return UserDefaults.standard.object(forKey: forKey) as? Float
    }
    
    /// Save an object to UserDefaults.
    ///
    /// - Parameters:
    ///   - value: object to save in UserDefaults.
    ///   - forKey: key to save object for.
    public static func set(value: Any?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    /// Class name of object as string.
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
//    public static func typeName(for object: Any) -> String {
//        let type = type(of: object.self)
//        return String.init(describing: type)
//    }
    
    
}


