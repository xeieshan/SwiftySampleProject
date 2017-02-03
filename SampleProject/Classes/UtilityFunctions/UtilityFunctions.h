//
//  UtilitiesFunctions.h
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

#import <MapKit/MKMapView.h>
#import <MapKit/MKPolyline.h>
#import <MapKit/MKPointAnnotation.h>
#import <MapKit/MKPolygon.h>

@class APIResponse;
@class Constants;

@interface UtilityFunctions : NSObject {
    BOOL disableSpinnerWhenLoadinImage;
}
typedef void(^UFAPIResponse)(APIResponse* apiResponse );

//@property (copy) void (^completionBlock)(UIAlertView* alertView, NSInteger buttonIndex);
@property (nonatomic, assign) BOOL disableSpinnerWhenLoadinImage;

+ (BOOL)isValidEmailAddress:(NSString *)emailText;
+ (BOOL)isValidateAlphabetWithWhiteSpace:(NSString *)checkString;

//+ (void)setupApplicationUIAppearance;

//+ (void)showAlertView:(NSString*)title message:(NSString*)message;
//+ (UIAlertView*)showAlertView:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle withTag:(int)tag withAccessibilityHint:(NSString*)accessibilityHint;

+ (BOOL)isValidateAlphabet:(NSString*)checkString;
+ (BOOL)isValidateSaudiaNumber:(NSString*)checkString;
+ (BOOL)isValidSaudiaNumber:(NSString *)string;
+ (BOOL)isValidStringAlphabet:(NSString*)string allowEmpty:(BOOL)allowEmpty;
+ (BOOL)isValidStringNumeric:(NSString*)string allowEmpty:(BOOL)allowEmpty;
+ (BOOL)isValidStringAlphabetSpace:(NSString*)string allowEmpty:(BOOL)allowEmpty;

+ (BOOL)isValueExist:(id)value;

+ (NSString*)postTextOnSocialNetwork:(NSString*)postMessage personName:(NSString*)personName goalTitle:(NSString*)goalTitle;

+ (UIViewController*)topMostController;

+ (UIImage*)resizeImage:(UIImage*)image toWidth:(float)width height:(float)height;

+ (NSString*)convertStringDate:(NSString*)date formatFrom:(NSString*)formatFrom formatTo:(NSString*)formatTo;
+ (NSString*)convertDateToString:(NSDate*)date withFormat:(NSString*)Format;
+ (NSDate*)convertStringToDate:(NSString*)date formatFrom:(NSString*)formatFrom;
+ (NSDate*) getDateFromJSON:(NSString *)dateString;

+ (void)setViewCornerRadius:(UIView*)view radius:(float)radius;
+ (void)setDropShadowOnView:(UIView*)view shadowOffset:(CGSize)shadowOffset;
+ (void)setViewBorder:(UIView*)view withWidth:(float)width andColor:(UIColor*)color;
+ (void)setDropShadowOnTextField:(UITextField *)view shadowOffset:(CGSize)shadowOffset;
+ (void)setViewBorderBottom:(UIView *)view withWidth:(float)width andColor:(UIColor*)color;
+ (void)setViewBorderBottom:(UIView *)view withWidth:(float)width atDistanceFromBottom:(float)bottonY andColor:(UIColor*)color clipToBounds:(BOOL)clipToBounds;

//Font

+ (CGFloat)measureWidthOf:(NSString*)string withTextView:(UITextView*)textView;
+ (CGFloat)measureHeightOf:(NSString*)string withTextView:(UITextView*)textView;
+ (CGSize)getSizeOfString:(NSString*)string withTextView:(UITextView*)textView;

+(CGFloat)getLabelDymanicHeight:(UILabel*)label;
+(CGFloat)getLabelDymanicHeightOfStringWithText:(NSString *)text andFont:(UIFont *)font andFrame:(CGRect )frame;

+ (CGFloat)getHeightOfString:(NSString *)string withLabel:(UILabel*)lbl;
//File Managers
+ (BOOL)writeTextToFileAtPath:(NSString*)fileName stringToWrite:(NSString*)stringToWrite;

+ (NSString*)readTextFileAtPath:(NSString*)fileName;

+ (NSData*)getFileOnPath:(NSString*)fileName;

+ (BOOL)saveFileOnPath:(NSString*)fileName filePath:(NSString*)filePath fileData:(NSData*)dataToSave;

+ (BOOL)isFileExist:(NSString*)fileName;

+ (NSString*)getDocumentDirectoryPath;

+ (BOOL)deleteFileByFileName:(NSString*)fileName;

+ (NSString*)getMD5String:(NSString*)string;
+ (NSString*)getPrefferedLanguage;

//Add Border to Image
+ (UIImage*)imageWithBorderFromImage:(UIImage*)source;
+ (NSString*)getCommaSeperatedFormattedPrice:(double)price;

//Notifications

+ (void)updateJobCountOnMenu:(NSInteger)count;
+ (void)updateMessageCountOnMenu:(NSInteger)count;

+ (BOOL)isValidateNumber:(NSString*)checkString;
+ (void)saveSessionToDisk:(NSDictionary*)Session;
+ (NSDictionary*)loadSessionFromDisk;

+ (int)timeDifference:(NSDate*)currentDate fireDate:(NSDate*)fireDate;

+(UIWindow*)getKeyWindow;

+ (NSMutableAttributedString *) makeAttributedStringWithArrayOfAttributes:(NSArray *)array;

+ (BOOL)connectedToNetwork;

+ (void) saveNSObjectInNSUserDefault:(NSObject*) object forKey:(NSString *)key;
+ (void) removeNSObjectInNSUserDefaultforKey:(NSString *)key;
+ (NSObject *) getNSObjectFromNSUserDefaultforKey:(NSString *)key;


#pragma mark - Add/Remove UIRefreshControl to TableView -
+ (UIRefreshControl *)refreshControlWithBackgroundColor:(UIColor *)bgColor andSelector:(SEL)selector;
+ (void)hideRefreshControl:(UIRefreshControl *)refreshControl withTextColor:(UIColor *)color;

+ (void)zoomMapViewForAllAnnotations:(MKMapView*)aMapView;
+ (void)centreMapViewAtCoordinate :(CLLocation*)location andMapView:(MKMapView*)mapView ;
+ (void)zoomToPolyLine:(MKMapView*)map polyLine:(MKPolyline*)polyLine animated:(BOOL)animated;

+ (void)updateLocation;
+ (void)showAlertLocationDisabled;
+ (void)callPutAPI:(NSString *)link andParams:(NSDictionary*)params andResponse :(UFAPIResponse)responseApi;

+( NSUInteger) getTimeForTravelBetween:(CLLocation*) source andDestination:(CLLocation*)destination;
+( CGFloat) getDistinceInKMBetween:(CLLocation*) source andDestination:(CLLocation*)destination;
@end
