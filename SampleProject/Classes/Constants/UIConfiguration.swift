//
//  UIConfiguration.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//

import UIKit
import Foundation

@objc class UIConfiguration :NSObject {
    static let debugClearBackground = UIColor.clear
    static let debugClearBackground2 = UIColor.clear
    static let cellSeparatorHeight = 2
    static let METERS_PER_MILE = 1609.344
    static let WhiteColor = UIColor.white
    static let kCollectionCellBorderTop = 12.0
    static let kCollectionCellBorderBottom = 12.0
    static let kCollectionCellBorderLeft = 12.0
    static let kCollectionCellBorderRight = 12.0
    static let kCollectionCellContentOriginX = 7.0
    static let kCollectionCellImageTitlePaddingY = 16.0
    static let kCollectionCellTitleDescriptionPaddingY = 7.0
    static let kCollectionCellDescriptionSeperatorPaddingY = 7.0
    static let kCollectionCellSeperatorCurrentLevelPaddingY = 7.0
    static let kCollectionCellCurrentLevelNextCouponPaddingY = 0
    static let kCollectionCellNextCouponButtonCouponPaddingY = 7.0
    static let kCollectionCellCurrentLevelNextCouponPaddingXRight = (ConstantDevices.IS_IPHONE_5) ? 64.0 : 85.0
    static let kCollectionCellCurrentLevelNextCouponWidth = 70.0//(IS_IPAD) ? 80.0 :
    
    static let kCollectionCellQuantityWidth = 50.0
    static let kCollectionCellCurrentButtonCouponWidth = UIImage(named: "CollectionCell_Coupon")!.size.width
    
    static let IPHONE5_FRAME = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 568))
    static let IPHONE4_FRAME = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 320, height: 480))

    static let kCollectionViewBackground = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    //for viewBack 		0
    static let MainNavBackColor = UIColor(red: 0.18, green: 0.2, blue: 0.24, alpha: 1)
    
    class func getMainNavBackColor() -> UIColor {
        return UIConfiguration.MainNavBackColor
    }
    
    static let MainSideMenu = UIColor(red: 243.0 / 255.0, green: 152.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
    static let MainNavBackNewsListColor = UIColor.white//[UIColor colorWithRed:233./255. green:233./255. blue:233./255. alpha:1.]
    
    static let MainBackColor = UIColor(red: 242.0 / 255.0, green: 244.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    static let AdditionalBackColor = UIColor(red: 187.0 / 255.0, green: 191.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    static let MainNavTitleColor = UIColor(red: 61.0 / 255.0, green: 79.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
    static let kColor_Actionsheet = UIColor(red: 49.0 / 255.0, green: 45.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    //for black color
    static let BlackColor = UIColor.black
    //let WhiteColor = UIColor.whiteColor()
    static let grayColor = UIColor.gray
    // White Color
    static let ColorWhite = UIColor.white
    // Black Color
    static let ColorBlack = UIColor.black
    // Purple Color
    static let ColorPurple = UIColor(red: 236.0 / 255.0, green: 0.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    // Dark Text Color
    static let ColorDarkText = UIColor(red: 98.0 / 255.0, green: 98.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    // Dark Background Color
    static let ColorDarkBackground = UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
    // Section Header Bg Color
    static let ColorSectionHeaderBG = UIColor(red: 118.0 / 255.0, green: 118.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
    // Sunny Color
    static let ColorSunny = UIColor(red: 246.0 / 255.0, green: 122.0 / 255.0, blue: 22.0 / 255.0, alpha: 1.0)
    // Contrast Color
    static let ColorContrast = UIColor(red: 35.0 / 255.0, green: 35.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    // Ocean Color
    static let ColorOcean = UIColor(red: 8.0 / 255.0, green: 34.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
    // Pop Color
    static let ColorPop = UIColor(red: 208.0 / 255.0, green: 0, blue: 2.0 / 255.0, alpha: 1.0)
    // Red Blue Color
    static let ColorRedBlue = UIColor(red: 37.0 / 255.0, green: 183.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    // Pink Lady Color
    static let ColorPinkLady = UIColor(red: 166.0 / 255.0, green: 0, blue: 72.0 / 255.0, alpha: 1.0)
    //Gold Color
    static let ColorGold = UIColor(red: 216.0 / 255.0, green: 171.0 / 255, blue: 39.0 / 255.0, alpha: 1.0)
    // Red Color
    static let ColorRed = UIColor.red
    // Green Color
    static let ColorGreen = UIColor.green
    // Clear Color
    static let ColorClear = UIColor.clear
    // Light Gray Color
    static let ColorLightGray = UIColor.lightGray
    //#define ColorWithRGBAlpha(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
    static let appColor = UIColor(red: 85.0 / 255.0, green: 105.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
    static let menuColor = UIColor(red: 60.0 / 255.0, green: 78.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    static let menuSeperatorColor = UIColor(red: 42.0 / 255.0, green: 121.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
    //for placeHolder text color
    static let kPlaceholderColor = UIColor(red: 61.0 / 255.0, green: 61.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
    static let LightTextColor = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    static let VeryLightTextColor = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.4)
    //for cell selected
    static let HighlightedColor = UIColor(red: 232.0 / 255.0, green: 236.0 / 255.0, blue: 223.0 / 255.0, alpha: 1.0)
    //redcolor
    static let RedColor = UIColor(red: 232.0 / 255.0, green: 121.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    //yellowcolor
    static let YellowColor = UIColor(red: 255.0 / 255.0, green: 233.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
    //Profile Title Color
    static let ColorProfileTitle = UIColor(red: 41.0 / 255.0, green: 183.0 / 255.0, blue: 117.0 / 255.0, alpha: 1.0)
    //Profile Email Color
    static let BadgeColor = UIColor(red: 240.0 / 255.0, green: 58.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
    static let KPlaceholderImage: String = "brand-placeholder"
    
    //Font Names
    static let kFontRegularName: String = "Constantia"
    
    static let kFontBoldName: String = "Constantia-Bold"
    
    static let kFontItalicName: String = "Constantia-Italic"
    
    static let kFontBoldItalicName: String = "Constantia-BoldItalic"
    
    static let PlaceHolderImage = UIImage(named: "ImageName")
    
    static let UIFONTAPP:String = "HelveticaNeue"
    static let UIFONTAPPBOLD:String = "HelveticaNeue-Bold"
    static let UIFONTAPPITALIC:String = "HelveticaNeue-Italic"
    
    class func getUIFONTAPP() -> String {
        return UIConfiguration.UIFONTAPP
    }
    
    class func getUIFONTAPPBOLD() -> String {
        return UIConfiguration.UIFONTAPPBOLD
    }
    
    class func getUIFONTAPPITALIC() -> String {
        return UIConfiguration.UIFONTAPPITALIC
    }
    
    class func getUIFONTAPPREGULAR( sizeFont: CGFloat) -> UIFont {
        return UIFont(name: UIConfiguration.getUIFONTAPP(), size: sizeFont)!
    }
    
    class func getUIFONTBOLD( sizeFont: CGFloat) -> UIFont {
        return UIFont(name: UIConfiguration.getUIFONTAPPBOLD(), size: sizeFont)!
    }
    
    static let fontBold10 = UIConfiguration.getUIFONTBOLD(sizeFont: 10)
    static let fontBold12 = UIConfiguration.getUIFONTBOLD(sizeFont: 12)
    static let fontBold13 = UIConfiguration.getUIFONTBOLD(sizeFont: 13)
    static let fontBold14 = UIConfiguration.getUIFONTBOLD(sizeFont: 14)
    static let fontBold15 = UIConfiguration.getUIFONTBOLD(sizeFont: 15)
    static let fontBold16 = UIConfiguration.getUIFONTBOLD(sizeFont: 16)
    static let fontBold18 = UIConfiguration.getUIFONTBOLD(sizeFont: 18)
    static let fontBold20 = UIConfiguration.getUIFONTBOLD(sizeFont: 20)
    static let fontBold21 = UIConfiguration.getUIFONTBOLD(sizeFont: 21)
    static let fontBold22 = UIConfiguration.getUIFONTBOLD(sizeFont: 22)
    static let fontBold24 = UIConfiguration.getUIFONTBOLD(sizeFont: 24)
    
    static let fontLight12 = UIFont(name: UIConfiguration.getUIFONTAPP(), size: 12)
    static let fontLight13 = UIFont(name: UIConfiguration.getUIFONTAPP(), size: 13)
    static let fontLight14 = UIFont(name: UIConfiguration.getUIFONTAPP(), size: 14)
    static let fontLight15 = UIFont(name: UIConfiguration.getUIFONTAPP(), size: 15)
    
    
    static let kCollectionCellTitleFont = UIFont.systemFont(ofSize: (ConstantDevices.isIS_IPAD()) ? 15 : 13)
    static let kCollectionCellDescriptionFont = UIFont.systemFont(ofSize: (ConstantDevices.isIS_IPAD()) ? 15 : 13)
    static let kCollectionCellLevelCouponFont = UIFont.systemFont(ofSize: (ConstantDevices.isIS_IPAD()) ? 15 : ConstantDevices.IS_IPHONE_5 ? 8 : 9)
    static let kCollectionCellGameTypeFont = UIFont.systemFont(ofSize: (ConstantDevices.isIS_IPAD()) ? 15 : 13)//IS_IPHONE_5 ? UIFONTSYSTEM_REGULAR(12) : UIFONTSYSTEM_REGULAR(13)
    
    static let kCollectionCellTitleColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    static let kCollectionCellDescriptionColor = UIColor(red: 152.0 / 255.0, green: 152.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
    static let kCollectionCellGameTypeColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    static let kCollectionCellLevelCouponColor = UIColor(red: 72.0 / 255.0, green: 72.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    static let kCollectionCellQuantityColor = UIColor(red: 72.0 / 255.0, green: 72.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    static let kCollectionCellEndingInColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1)
    static let kCollectionCellToQualifyColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1)
    static let kCollectionCellBonusPrizeColor = UIColor(red: 72.0 / 255.0, green: 72.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    static let kCollectionCellPlaysColor = UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1)

    static let  NavBarBackImage = UIImage(named: "NavBack")
    static let  NavBarMenuImage = UIImage(named: "Nav_Menu")
    static let NavBarTickImage = UIImage(named: "Nav_Tick")
    static let NavBarPinPlusImage = UIImage(named: "M_PinTypeAddress")
    static let NavBarNotificationImage = UIImage(named: "Nav_Notification")
    static let NavBarNotificationBarredImage = UIImage(named: "Nav_Notification_Barred")
    static let NavBarLogoutImage = UIImage(named: "Nav_Logout")
    static let NavBarPlusImage = UIImage(named: "Nav_Plus")
    static let NavBarAlertImage = UIImage(named: "Nav-Alert")
    static let NavBarDirectionImage = UIImage(named: "Nav-Direction")
    static let NavBarNextImage = UIImage(named: "next_btn_normal.png")
    static let NavBarOptionImage = UIImage(named: "menuOption.png")
    static let NavBarAddImage = UIImage(named: "add_new.png")
    static let NavBarShareImage = UIImage(named: "share_black.png")
    static let NavBarDoneImage = UIImage(named: "done_btn.png")
    static let NavBarSettingImage = UIImage(named: "settings_grey_icon.png")
    static let NavBarMessagesImage = UIImage(named: "alert_icon.png")
    static let NavBarNewsList = UIImage(named: "NavigationBar-NewsList.png")
    static let BACKGROUND_IMAGE = UIImage(named: "bg_image.png")
    static let IMAGE_DROPDOWN_DOB = UIImage(named: "dob_dropdown.png")
    static let IMAGE_DROPDOWN_LOCATION = UIImage(named: "location_dropdown.png")
    static let IMAGE_PLACEHOLDER_CATEGORY_GALLERY = UIImage(named: "Newslist_place_holder.png")
    static let IMAGE_PLACEHOLDER_NEWSLIST_CELL = UIImage(named: "NewslistCell_place_holder.png")
    static let IMAGE_PLACEHOLDER_NEWSDETAIL = UIImage(named: "Newsdetail_place_holder.png")
    static let IMAGE_INACTIVE_PAGE = UIImage(named: "Selected-Page.png")
    static let IMAGE_ACTIVE_PAGE = UIImage(named: "Selected-Page.png")
    //Messages
    static let IMAGE_APPLOGO = UIImage(named: "AppLogo")
    static let IMAGE_LEFT_PATTERN = UIImage(named: "LeftPatternMenu")
    static let kSeperator_Image = "seprator.png"
    static let kSelected_Background_Color = UIColor(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0);
    static let BookingRoundedViewBorder = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    static let IMAGE_HUD_TICK = UIImage(named: "Success")
    static let IMAGE_HUD_CROSS = UIImage(named: "Fail")
    
}

