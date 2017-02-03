//
//  Theme.swift
//  juliengdt
//
//  Created by julien.GOUDET on 26/10/2015.
//  Copyright © 2015 julien.GOUDET. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Custom Theme application - inspired by Chameleon
 */
public struct Theme {
    private static var sharedTheme: ThemeProtocol = ThemeDefault()

    
    public static func localizableString(key: String) -> String {
        if let bundle = Theme.sharedTheme.bundle {
            return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(key, comment: "")
        }
    }
    
    public static func applyThemeAppearance() {
        
        let themeProtocol                                = Theme.sharedTheme

        // Status Bar
        customizedStatusBarWithStyle(themeProtocol.statusBarStyle)
        
        customizedButtonUsingPrimaryColor(themeProtocol.primaryButtonColor, contentColor: themeProtocol.backgroundButtonColor)
        
        customizedLabelUsingTextColor(themeProtocol.labelTextColor, textFont: themeProtocol.labelFont)
        
        customizedBarButtonItemUsingPrimaryColor(themeProtocol.barButtonItemColor, contentColor: themeProtocol.barButtonItemContainedColor)
        
        customizedNavigationBarUsingBarColor(themeProtocol.navigationBarColor, contentColor: themeProtocol.navigationBarTintColor,
                                        textColor: themeProtocol.navigationBarTextColor, textFont: themeProtocol.navigationBarFont)
        
        customizedPageControlUsingPrimaryColor(themeProtocol.pageControlColor, contentColor: themeProtocol.pageControlContainedColor)
        
        customizedProgressViewUsingPrimaryColor(themeProtocol.progressViewColor, contentColor: themeProtocol.progressViewContainedColor)
        
        customizedSearchBarUsingPrimaryColor(themeProtocol.searchBarColor, contentColor: themeProtocol.searchBarTintColor)
        
        customizedSegmentedControlUsingPrimaryColor(themeProtocol.segmentedControlColor, contentColor: themeProtocol.segmentedControlContainedColor,
                                                textColor: themeProtocol.segmentedControlTextColor, textFont: themeProtocol.segmentedControlFont)
        
        customizedSliderUsingMinColor(themeProtocol.sliderMinColor, maxColor: themeProtocol.sliderMaxColor, thumbColor: themeProtocol.sliderThumbColor)
        
        customizedSwitchUsingOffColor(themeProtocol.switchOffColor, contentColor: themeProtocol.switchThumbColor, onColor: themeProtocol.switchOnColor)
        

    }
    
    private static func customizedStatusBarWithStyle(style: UIStatusBarStyle) {
        UIApplication.sharedApplication().statusBarStyle = style

    }
    
    private static func customizedButtonUsingPrimaryColor(primColor: UIColor, contentColor: UIColor) {
        
        UIButton.appearance().tintColor       = contentColor
        UIButton.appearance().backgroundColor = primColor

        UIButton.swiftAppearanceWhenContainedIn(UISearchBar.self).tintColor           = contentColor
        UIButton.swiftAppearanceWhenContainedIn(UISearchBar.self).backgroundColor     = .clearColor()

        UIButton.swiftAppearanceWhenContainedIn(UINavigationBar.self).tintColor       = contentColor
        UIButton.swiftAppearanceWhenContainedIn(UINavigationBar.self).backgroundColor = .clearColor()

        UIButton.swiftAppearanceWhenContainedIn(UIToolbar.self).tintColor             = contentColor
        UIButton.swiftAppearanceWhenContainedIn(UIToolbar.self).backgroundColor       = .clearColor()
        
        UIButton.appearance().setTitleShadowColor(.clearColor(), forState: .Normal)
        
    }
    
    private static func customizedLabelUsingTextColor(textColor: UIColor, textFont: UIFont) {

        UILabel.appearance().font                                         = textFont
        UILabel.swiftAppearanceWhenContainedIn(UITextField.self).font     = textFont
        UILabel.swiftAppearanceWhenContainedIn(UIButton.self).font        = textFont
        UILabel.swiftAppearanceWhenContainedIn(UINavigationBar.self).font = textFont

        UILabel.appearance().textColor                                         = textColor
        
        UILabel.swiftAppearanceWhenContainedIn(UINavigationBar.self).textColor = textColor
        UILabel.swiftAppearanceWhenContainedIn(UIToolbar.self).textColor       = textColor
        
    }
    
    private static func customizedBarButtonItemUsingPrimaryColor(primColor: UIColor, contentColor: UIColor) {
        
        UIBarButtonItem.appearance().tintColor = primColor
        
        UIBarButtonItem.swiftAppearanceWhenContainedIn(UISearchBar.self).tintColor     = contentColor
        UIBarButtonItem.swiftAppearanceWhenContainedIn(UINavigationBar.self).tintColor = contentColor
        UIBarButtonItem.swiftAppearanceWhenContainedIn(UIToolbar.self).tintColor       = contentColor

    }
    
    private static func customizedNavigationBarUsingBarColor(barColor: UIColor, contentColor: UIColor, textColor: UIColor, textFont: UIFont) {
        
        let barAppearance = UINavigationBar.appearance()
        
        barAppearance.barTintColor        = barColor
        barAppearance.tintColor           = contentColor
        barAppearance.titleTextAttributes = [NSForegroundColorAttributeName: textColor, NSFontAttributeName: textFont]
        barAppearance.shadowImage         = UIImage()
        
    }
    
    private static func customizedPageControlUsingPrimaryColor(primColor: UIColor, contentColor: UIColor) {
        
        UIPageControl.appearance().currentPageIndicatorTintColor = primColor
        UIPageControl.appearance().pageIndicatorTintColor        = primColor.colorWithAlphaComponent(0.4)
        
        UIPageControl.swiftAppearanceWhenContainedIn(UINavigationBar.self).currentPageIndicatorTintColor = contentColor
        UIPageControl.swiftAppearanceWhenContainedIn(UINavigationBar.self).pageIndicatorTintColor        = contentColor.colorWithAlphaComponent(0.4)
        UIPageControl.swiftAppearanceWhenContainedIn(UIToolbar.self).currentPageIndicatorTintColor       = contentColor
        UIPageControl.swiftAppearanceWhenContainedIn(UIToolbar.self).pageIndicatorTintColor              = contentColor.colorWithAlphaComponent(0.4)
        
    }
    
    private static func customizedProgressViewUsingPrimaryColor(primColor: UIColor, contentColor: UIColor) {
        
        UIProgressView.appearance().progressTintColor                                         = primColor
        UIProgressView.appearance().trackTintColor = .lightGrayColor()
        
        
        UIProgressView.swiftAppearanceWhenContainedIn(UINavigationBar.self).progressTintColor = contentColor
        UIProgressView.swiftAppearanceWhenContainedIn(UINavigationBar.self).trackTintColor    = primColor.darkenByPercentage(0.25)
        UIProgressView.swiftAppearanceWhenContainedIn(UIToolbar.self).progressTintColor       = contentColor
        UIProgressView.swiftAppearanceWhenContainedIn(UIToolbar.self).trackTintColor          = primColor.darkenByPercentage(0.25)

        
    }
    
    private static func customizedSearchBarUsingPrimaryColor(primColor: UIColor, contentColor: UIColor) {
        
        let searchBarAppearance = UISearchBar.appearance()
        
        searchBarAppearance.barTintColor    = primColor
        searchBarAppearance.backgroundColor = primColor
        searchBarAppearance.tintColor       = contentColor
        
        searchBarAppearance.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
        
    }
    
    private static func customizedSegmentedControlUsingPrimaryColor(primColor: UIColor, contentColor: UIColor, textColor: UIColor, textFont: UIFont) {
        
        UISegmentedControl.appearance().tintColor = primColor
    
        UISegmentedControl.swiftAppearanceWhenContainedIn(UINavigationBar.self).tintColor = contentColor
        UISegmentedControl.swiftAppearanceWhenContainedIn(UIToolbar.self).tintColor       = contentColor
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: textColor, NSFontAttributeName: textFont], forState: .Normal)
    
    }

    private static func customizedSliderUsingMinColor(minColor: UIColor, maxColor: UIColor, thumbColor: UIColor) {
        
        let sliderAppearance = UISlider.appearance()
        
        sliderAppearance.thumbTintColor        = thumbColor
        sliderAppearance.minimumTrackTintColor = minColor
        sliderAppearance.maximumTrackTintColor = maxColor
        
        let sliderAppearanceT = UISlider.swiftAppearanceWhenContainedIn(UIToolbar.self)
        let sliderAppearanceN = UISlider.swiftAppearanceWhenContainedIn(UINavigationBar.self)
        
        sliderAppearanceT.thumbTintColor        = thumbColor
        sliderAppearanceT.minimumTrackTintColor = minColor
        sliderAppearanceT.maximumTrackTintColor = maxColor
        
        sliderAppearanceN.thumbTintColor        = thumbColor
        sliderAppearanceN.minimumTrackTintColor = minColor
        sliderAppearanceN.maximumTrackTintColor = maxColor
        
    }
    
    private static func customizedSwitchUsingOffColor(primColor: UIColor, contentColor: UIColor, onColor: UIColor) {
        
        let switchAppearance = UISwitch.appearance()
        
        switchAppearance.tintColor      = contentColor
        switchAppearance.onTintColor    = onColor
        switchAppearance.thumbTintColor = primColor
        
        let switchAppearanceT = UISwitch.swiftAppearanceWhenContainedIn(UIToolbar.self)
        
        switchAppearanceT.tintColor      = contentColor
        switchAppearanceT.onTintColor    = onColor
        switchAppearanceT.thumbTintColor = primColor
        
        let switchAppearanceN = UISwitch.swiftAppearanceWhenContainedIn(UINavigationBar.self)
        
        switchAppearanceN.tintColor      = contentColor
        switchAppearanceN.onTintColor    = onColor
        switchAppearanceN.thumbTintColor = primColor

    }
    

    
}


/**
 *  Scheme used to give ui assets such as fonts and colors
 */
protocol ThemeProtocol {
    
    // Global
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var barBackgroundColor: UIColor { get }
    var barTextColor: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var bundleName: String { get }
    var backgroundColor: UIColor { get }
    
    
    
    /// Custom Theming Appearance
    
    // Button
    var primaryButtonColor: UIColor { get }
    var backgroundButtonColor: UIColor { get }
    
    // Label
    var labelFont: UIFont { get }
    var labelTextColor: UIColor { get }

    
    // BarButton
    var barButtonItemColor: UIColor { get }
    var barButtonItemContainedColor: UIColor { get }
    
    // NavigationBar
    var navigationBarColor: UIColor { get }
    var navigationBarTintColor: UIColor { get }
    var navigationBarFont: UIFont { get }
    var navigationBarTextColor: UIColor { get }
    
    // PageControl
    var pageControlColor: UIColor { get }
    var pageControlContainedColor: UIColor { get }

    
    // ProgressView
    var progressViewColor: UIColor { get }
    var progressViewContainedColor: UIColor { get }

    //SearchBar
    var searchBarColor: UIColor { get }
    var searchBarTintColor: UIColor { get }

    
    // SegmentedControl
    var segmentedControlColor: UIColor { get }
    var segmentedControlContainedColor: UIColor { get }
    var segmentedControlFont: UIFont { get }
    var segmentedControlTextColor: UIColor { get }
    
    // UISlider
    var sliderThumbColor: UIColor { get }
    var sliderMinColor: UIColor { get }
    var sliderMaxColor: UIColor { get }

    // UISWitch
    var switchThumbColor: UIColor { get }
    var switchOnColor: UIColor { get }
    var switchOffColor: UIColor { get }
    
    
    
    
    // Font
    func fontForStyle(style: FontTextStyle) -> UIFont
    
}

/**
 *  Default ThemeProtocol to use in the app, all color, radius, alpha or anything MUST be here
 *  to have a coherent UI Guideline for the app
 */
struct ThemeDefault: ThemeProtocol {
    
    // MARK: Global
    var primaryColor: UIColor {
        return UIColor.blueColor()
    }
    
    var secondaryColor: UIColor {
        return UIColor.whiteColor()
    }
    
    var barBackgroundColor: UIColor {
        return peterRiverColor
    }
    
    var barTextColor: UIColor {
        return cloudsColor
    }
    
    var statusBarStyle: UIStatusBarStyle {
        return .LightContent
    }
    
    var bundleName: String {
        return "Default"
    }
    
    var backgroundColor: UIColor {
        return cloudsColor
    }
    
    
    
    
    // Button
    var primaryButtonColor: UIColor {
        return .blackColor()
    }
    var backgroundButtonColor: UIColor {
        return .blackColor()
    }
    
    // Label
    var labelFont: UIFont {
        return fontForStyle(.Body)
    }
    var labelTextColor: UIColor {
        return .blackColor()
    }

    
    // BarButton
    var barButtonItemColor: UIColor {
        return .blackColor()
    }
    var barButtonItemContainedColor: UIColor {
        return .blackColor()
    }
    
    // NavigationBar
    var navigationBarColor: UIColor {
        return .blackColor()
    }
    var navigationBarTintColor: UIColor {
        return .blackColor()
    }
    var navigationBarFont: UIFont {
        return fontForStyle(.Headline)
    }
    var navigationBarTextColor: UIColor {
        return .blackColor()
    }
    
    // PageControl
    var pageControlColor: UIColor {
        return .blackColor()
    }
    var pageControlContainedColor: UIColor {
        return .blackColor()
    }

    
    // ProgressView
    var progressViewColor: UIColor {
        return .blackColor()
    }
    var progressViewContainedColor: UIColor {
        return .blackColor()
    }
    
    //SearchBar
    var searchBarColor: UIColor {
        return .blackColor()
    }
    var searchBarTintColor: UIColor {
        return .blackColor()
    }

    
    // SegmentedControl
    var segmentedControlColor: UIColor {
        return .blackColor()
    }
    var segmentedControlContainedColor: UIColor {
        return .blackColor()
    }
    var segmentedControlFont: UIFont {
        return fontForStyle(.Body)
    }
    var segmentedControlTextColor: UIColor {
        return .blackColor()
    }
    
    // UISlider
    var sliderThumbColor: UIColor {
        return .blackColor()
    }
    var sliderMinColor: UIColor {
        return .blackColor()
    }
    var sliderMaxColor: UIColor {
        return .blackColor()
    }
    
    // UISWitch
    var switchThumbColor: UIColor {
        return .blackColor()
    }
    var switchOnColor: UIColor {
        return .blackColor()
    }
    var switchOffColor: UIColor {
        return .blackColor()
    }

    
    
    // MARK: Font
    func preferredFontForTextStyle(fontDescriptor: String) -> UIFont {
        return UIFont.preferredFontForTextStyle(fontDescriptor)
    }
    
    /**
     Call this function to get the reliable font, depending on what you want to display.<br>
     Note: size is default one, suggested by Apple Guidelines: 17pts for system font
     
     - parameter style: The custom style you want to use
     
     - returns: The font you have to use
     */
    func fontForStyle(style: FontTextStyle) -> UIFont {
        switch style {
        case .Title:
            return UIFont.systemFontOfSize(17)
        case .Headline:
            return UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        case .SubHeadline:
            return UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        case .Body:
            return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        case .BodyLight:
            if let font = UIFont.systemLightFontOfSize() {
                return font
            }
            return UIFont.systemFontOfSize(17)
        case .BodyUltraLight:
            if let font = UIFont.systemUltraLightFontOfSize() {
                return font
            }
            return UIFont.systemFontOfSize(17)
        case .Footnote:
            return UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        }
    }
    
    // MARK: Colors
    
    /// Very light white
    let cloudsColor       = UIColor(hex: "ecf0f1")

    /// Green
    let turquoiseColor    = UIColor(hex: "1abc9c")

    /// Dark green
    let greenSeaColor     = UIColor(hex: "16a085")

    /// Light blue
    let peterRiverColor   = UIColor(hex: "3498db")

    /// Blue
    let belizeHoleColor   = UIColor(hex: "2980b9")

    /// Dark blue
    let wetAsphaltColor   = UIColor(hex: "395067")

    /// Very dark blue
    let midnightBlueColor = UIColor(hex: "2c3e50")

    /// Grey
    let silverColor       = UIColor(hex: "bdc3c7")

    /// Dark grey
    let asbestosColor     = UIColor(hex: "7f8c8d")

    /// Red
    let alizarinColor     = UIColor(hex: "e74c3c")

    /// Dark Red
    let pomegranateColor  = UIColor(hex: "c0392b")
}

//MARK: - Extensions -

extension ThemeProtocol
{
    var bundle: NSBundle? {
        return NSBundle.bundleWithName(self.bundleName)
    }
}

extension NSBundle
{
    static func bundleWithName(bundleName: String?) -> NSBundle? {
        if let path = NSBundle.mainBundle().pathForResource(bundleName, ofType: "bundle") {
            return NSBundle(path: path)
        }
        return nil
    }
}

extension UIFont {
    
    public class func systemLightFontOfSize(fontSize: CGFloat = 17) -> UIFont? {
        if Float(UIDevice.currentDevice().systemVersion) < 9.0 {
            return UIFont(name: "HelveticaNeue-Light", size: fontSize)
        }else {
            return UIFont(name: "SF-UI-Display-Light", size: fontSize)
        }
    }
    
    public class func systemUltraLightFontOfSize(fontSize: CGFloat = 17) -> UIFont? {
        if Float(UIDevice.currentDevice().systemVersion) < 9.0 {
            return UIFont(name: "HelveticaNeue-UltraLight", size: fontSize)
        }else {
            return UIFont(name: "SF-UI-Display-Ultralight", size: fontSize)
        }
    }
}