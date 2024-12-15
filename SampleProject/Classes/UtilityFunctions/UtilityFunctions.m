//
//  UtilitiesFunctions.m
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 16/07/2015.
//  Copyright (c) 2015 <#Project Name#>. All rights reserved.
//

//#import "UtilityFunctions.h"
//
//#import <CommonCrypto/CommonDigest.h>
//
//#import <SystemConfiguration/SCNetworkReachability.h>
//#include <netinet/in.h>
////#import "SVProgressHUD.h"
//
//
//@implementation UtilityFunctions
//@synthesize disableSpinnerWhenLoadinImage=_disableSpinnerWhenLoadinImage;
//
//+ (BOOL)isValidEmailAddress:(NSString *)emailText
//{
//    /* BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
//     NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
//     NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
//     NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
//     NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//     BOOL isValid = [emailTest evaluateWithObject:emailText];
//     return isValid;*/
//    
//    NSString *emailRegEx =
//    @"(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
//    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
//    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-"
//    @"zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5"
//    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
//    @"9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
//    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
//    
//    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
//    BOOL isValid = [regExPredicate evaluateWithObject:emailText];
//    
//    return isValid;
//}
//+(BOOL)isValidateNumber:(NSString*)checkString
//{
//    NSCharacterSet* numcharacters = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int characterCount = 0;
//    
//    NSUInteger i;
//    for (i = 0; i < [checkString length]; i++)
//    {
//        unichar character = [checkString characterAtIndex:i];
//        if(![numcharacters characterIsMember:character])
//        {
//            characterCount ++;
//        }
//    }
//    
//    if(characterCount == 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
//
//+(BOOL)isValidateSaudiaNumber:(NSString*)checkString
//{
//    //+966126123100
//    //http://regexlib.com/Search.aspx?k=saudi&c=-1&m=-1&ps=20
//    //https://gist.github.com/homaily/8672499
//    //https://regex101.com
//    NSCharacterSet* numcharacters = [NSCharacterSet characterSetWithCharactersInString:@"^(009665|9665|+9665|05|+966)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})"];
//    int characterCount = 0;
//    
//    NSUInteger i;
//    for (i = 0; i < [checkString length]; i++)
//    {
//        unichar character = [checkString characterAtIndex:i];
//        if(![numcharacters characterIsMember:character])
//        {
//            characterCount ++;
//        }
//    }
//    
//    if(characterCount == 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
//
//+(BOOL)isValidateAlphabet:(NSString *)checkString
//{
//    NSCharacterSet* numcharacters = [NSCharacterSet characterSetWithCharactersInString:@" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
//    int characterCount = 0;
//    
//    NSUInteger i;
//    for (i = 0; i < [checkString length]; i++)
//    {
//        unichar character = [checkString characterAtIndex:i];
//        if(![numcharacters characterIsMember:character])
//        {
//            characterCount ++;
//        }
//    }
//    
//    if(characterCount == 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
//+(BOOL)isValidateAlphabetWithWhiteSpace:(NSString *)checkString
//{
//    NSCharacterSet* numcharacters = [NSCharacterSet characterSetWithCharactersInString:@" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
//    int characterCount = 0;
//    
//    NSUInteger i;
//    for (i = 0; i < [checkString length]; i++)
//    {
//        unichar character = [checkString characterAtIndex:i];
//        if(![numcharacters characterIsMember:character])
//        {
//            characterCount ++;
//        }
//    }
//    
//    if(characterCount == 0)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
////+ (void)setupApplicationUIAppearance
////{
////    //    [[UILabel appearance] setFont:UIFONTSYSTEM_REGULAR(IS_IPAD? 22:14)];
////    //    [UIButton appearance].titleLabel.font =UIFONTSYSTEM_REGULAR(IS_IPAD? 22:14);
////    
////    [[UILabel appearance] setSubstituteFontName:[UIConfiguration getUIFONTAPP]];
////    
////    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIConfiguration getUIFONTAPPREGULAR:13], NSFontAttributeName, nil] forState:UIControl.StateNormal];
////    
////    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
////    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIConfiguration getUIFONTAPPREGULAR:17]}];
////    
////    //Back
////    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
////     @{NSTextEffectAttributeName:[UIColor whiteColor],
////       NSFontAttributeName:[UIConfiguration getUIFONTAPPREGULAR:16]} forState:UIControl.StateNormal];
////    
////    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"Nav_Back"] forState:UIControl.StateNormal barMetrics:UIBarMetricsDefault];
////    
////    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"Nav_Back"]];
////    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"Nav_Back"]];
////    
////    CGRect rect = CGRectMake(0.0f, 0.0f, [Constants getApplicationDelegate].window.frame.size.width, 64.0f);
////    UIGraphicsBeginImageContext(rect.size);
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    
////    CGContextSetFillColorWithColor(context, [[UIConfiguration getMainNavBackColor] CGColor]);
////    CGContextFillRect(context, rect);
////    
////    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    
////    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
////    
////}
//
////+(void)showAlertView:(NSString *)title message:(NSString *)message
////{
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles: nil];
////    [alert show];
////    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* notification)
////     {
////         [alert dismissWithClickedButtonIndex:0 animated:NO];
////     }];
////}
//
////+(UIAlertView*)showAlertView:(NSString *)title message:(NSString *)message delegate :(id)delegate cancelButtonTitle :(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle withTag:(int)tag withAccessibilityHint:(NSString *)accessibilityHint
////{
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitle, nil];
////    alert.tag = tag;
////    alert.accessibilityHint=accessibilityHint;
////    [alert show];
////    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* notification)
////     {
////         [alert dismissWithClickedButtonIndex:0 animated:NO];
////     }];
////    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* notification)
////     {
////         [alert dismissWithClickedButtonIndex:0 animated:NO];
////     }];
////    return alert;
////}
//
//+(NSString*)getPrefferedLanguage
//{
//    for (NSString* languageItem in [NSLocale preferredLanguages])
//    {
//        if ([languageItem isEqualToString:@"en"] ||
//            [languageItem isEqualToString:@"ru"] ||
//            [languageItem isEqualToString:@"uk"] ||
//            [languageItem isEqualToString:@"de"] ||
//            [languageItem isEqualToString:@"fr"] ||
//            [languageItem isEqualToString:@"it"] ||
//            [languageItem isEqualToString:@"es"] ||
//            [languageItem isEqualToString:@"ar"])
//        {
//            return languageItem;
//        }
//    }
//    return  @"en";
//}
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}
//
////- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion
////{
////    UIAlertView *alertWrapper = [[UIAlertView alloc] init];
////    self.completionBlock = completion;
////    alertWrapper.delegate = alertWrapper;
////    [alertWrapper show];
////}
////- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
////{
////    if (self.completionBlock)
////        self.completionBlock(alertView, buttonIndex);
////}
////
////// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
////// If not defined in the delegate, we simulate a click in the cancel button
////- (void)alertViewCancel:(UIAlertView *)alertView
////{
////    // Just simulate a cancel button click
////    if (self.completionBlock)
////        self.completionBlock(alertView, alertView.cancelButtonIndex);
////}
//#pragma mark- Data Validation
//+(BOOL) isValidStringAlphabet:(NSString *)string allowEmpty:(BOOL)allowEmpty
//{
//    if (allowEmpty)
//    {
//        if (string.length==0) return YES;
//    }
//    else
//    {
//        if (string.length==0) return NO;
//    }
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
//    
//    if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
//    {
//        NSLog(@"This string contains illegal characters");
//        return NO;
//    }
//    return YES;
//}
//+(BOOL) isValidStringAlphabetSpace:(NSString *)string allowEmpty:(BOOL)allowEmpty
//{
//    if (allowEmpty)
//    {
//        if (string.length==0) return YES;
//    }
//    else
//    {
//        if (string.length==0) return NO;
//    }
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ "] invertedSet];
//    
//    if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
//    {
//        NSLog(@"This string contains illegal characters");
//        return NO;
//    }
//    return YES;
//}
//+(BOOL) isValidStringNumeric:(NSString *)string allowEmpty:(BOOL)allowEmpty
//{
//    if (allowEmpty)
//    {
//        if (string.length==0) return YES;
//    }
//    else
//    {
//        if (string.length==0) return NO;
//    }
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"] invertedSet];
//    
//    if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
//    {
//        NSLog(@"This string contains illegal characters");
//        return NO;
//    }
//    return YES;
//}
//+(BOOL) isValidSaudiaNumber:(NSString *)string
//{
//    /**
//     *  if(!(phone.charAt(0) == '0'))
//     return false;
//     if(!(phone.length() == 10))
//     return false;
//     return true;
//     */
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//    
//    if ([string rangeOfCharacterFromSet:set].location != NSNotFound)
//    {
//        NSLog(@"This string contains illegal characters");
//        return NO;
//    }
//    NSString *first = [NSString stringWithFormat:@"%@", [string substringWithRange:NSMakeRange(0, 1)]];
//    if (![first isEqualToString:@"0"]) {
//        return NO;
//    }
//    if (string.length != 10) {
//        return NO;
//    }
//    return YES;
//}
//
//+(CGFloat)getLabelDymanicHeightOfStringWithText:(NSString *)text andFont:(UIFont *)font andFrame:(CGRect )frame
//{
//    CGSize maxSize = CGSizeMake(frame.size.width, 999999.0);
//    int height = 0;
//    
//    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                          font, NSFontAttributeName,
//                                          nil];
//    
//    CGRect frame1 = [text boundingRectWithSize:maxSize
//                                       options:NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:attributesDictionary
//                                       context:nil];
//    height = frame1.size.height;
//    
//    return height+5;
//}
//
//+(CGFloat)getLabelDymanicHeight:(UILabel*)label
//{
//    CGSize maxSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
//    int height = 0;
//    
//    UIFont *font = label.font;
//    
//    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                          font, NSFontAttributeName,
//                                          nil];
//    
//    CGRect frame = [label.text boundingRectWithSize:maxSize
//                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                         attributes:attributesDictionary
//                                            context:nil];
//    height = frame.size.height;
//    label.numberOfLines=0;
//    return height+5;
//}
//
//
//+(NSString *)convertStringDate :(NSString*)date formatFrom :(NSString*)formatFrom formatTo :(NSString*)formatTo
//{
//    NSString *dateString = date;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    // this is imporant - we set our input date format to match our input string
//    // if format doesn't match you'll get nil from your string, so be careful
//    [dateFormatter setDateFormat:formatFrom];
//    NSDate *dateFromString;
//    dateFromString = [dateFormatter dateFromString:dateString];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:formatTo];
//    
//    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//    
//    NSString *birthday = [formatter stringFromDate:dateFromString];
//    
//    return birthday;
//}
//+ (NSDate*) getDateFromJSON:(NSString *)dateString
//{
//    // Expect date in this format "/Date(1268123281843)/"
//    NSInteger startPos = [dateString rangeOfString:@"("].location+1;
//    NSInteger endPos = [dateString rangeOfString:@")"].location;
//    NSRange range = NSMakeRange(startPos,endPos-startPos);
//    unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
//    NSLog(@"%llu",milliseconds);
//    NSTimeInterval interval = milliseconds/1000;
//    return [NSDate dateWithTimeIntervalSince1970:interval];
//}
//
//+(NSString *)convertDateToString: (NSDate*)date withFormat:(NSString *)Format
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:Format];
//    
//    NSString *stringFromDate = [formatter stringFromDate:date];
//    return stringFromDate;
//}
//+(NSDate *)convertStringToDate :(NSString*)date formatFrom :(NSString*)formatFrom
//{
//    NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
//    [myFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//    //    [myFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:@"Gregorion"]];
//    [myFormatter setDateFormat:formatFrom];
//    NSDate* myDate = [myFormatter dateFromString:date];
//    
//    return myDate;
//}
//+(BOOL)isValueExist:(id)value
//{
//    if ([value isKindOfClass:[NSNull class]] || value == nil)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//
//+(NSString*)postTextOnSocialNetwork :(NSString*)postMessage personName: (NSString*)personName goalTitle:(NSString*)goalTitle
//{
//    return [NSString stringWithFormat:@"%@ %@ %@ shared via %@ iPhone app",postMessage,personName,goalTitle,@""];
//}
//
//
//+ (UIViewController*) topMostController
//{
//    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    while (topController.presentedViewController) {
//        topController = topController.presentedViewController;
//    }
//    
//    return topController;
//}
//
//
//
//+(UIImage *)resizeImage:(UIImage *)image toWidth:(float)width height:(float)height
//{
//    UIGraphicsBeginImageContext(CGSizeMake(width, height));
//    
//    [image drawInRect:CGRectMake(0, 0, width, height)];
//    
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}
//+(void)setViewBorder:(UIView *)yourView withWidth:(float)borderWidth andColor:(UIColor*)borderColor cornerRadius:(float)radius andShadowColor:(UIColor*)shadowColor shadowRadius:(float)shadowRadius
//{
//    // border radius
//    [yourView.layer setCornerRadius:radius];
//    
//    // border
//    [yourView.layer setBorderColor:borderColor.CGColor];
//    [yourView.layer setBorderWidth:borderWidth];
//    
//    // drop shadow
//    [yourView.layer setShadowColor:shadowColor.CGColor];
//    [yourView.layer setShadowOpacity:0.8];
//    [yourView.layer setShadowRadius:shadowRadius];
//    [yourView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
//}
//+(void)setViewBorder:(UIView *)view withWidth:(float)width andColor:(UIColor*)color
//{
//    view.layer.borderColor = [color CGColor];
//    view.layer.borderWidth = 1.;
//}
//+(void)setViewCornerRadius:(UIView *)view radius:(float)radius
//{
//    view.layer.cornerRadius = radius;
//    view.layer.masksToBounds = YES;
//}
//
//+(void)setViewBorderBottom:(UIView *)view withWidth:(float)width andColor:(UIColor*)color
//{
//    [view layoutIfNeeded];
//    CALayer *bottomBorder = [CALayer layer];
//    
//    bottomBorder.frame = CGRectMake(0.0f, view.frame.size.height-0.5, view.frame.size.width, 0.5);
//    
//    bottomBorder.backgroundColor = color.CGColor;
//    
//    [view.layer addSublayer:bottomBorder];
//    view.clipsToBounds = YES;
//}
//
//+(void)setViewBorderBottom:(UIView *)view withWidth:(float)width atDistanceFromBottom:(float)bottonY andColor:(UIColor*)color clipToBounds:(BOOL)clipToBounds
//{
//    [view layoutIfNeeded];
//    CALayer *bottomBorder = [CALayer layer];
//    /*
//     UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, view.frame.size.height-bottonY, view.frame.size.width, width)];
//     bottomBorder.backgroundColor = color;
//     [view addSubview:bottomBorder];
//     */
//    bottomBorder.frame = CGRectMake(0.0f, view.frame.size.height-bottonY, view.frame.size.width, width);
//    bottomBorder.backgroundColor = color.CGColor;
//    [view.layer addSublayer:bottomBorder];
//    view.clipsToBounds = clipToBounds;
//}
//
//+(void)setDropShadowOnView:(UIView *)view shadowOffset:(CGSize)shadowOffset
//{
//    [view.layer setShadowOffset:shadowOffset];
//    [view.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
//    [view.layer setShadowRadius:5.0];
//    [view.layer setShadowOpacity:0.7];
//    
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:view.layer.bounds].CGPath;
//    [view.layer setShadowPath:shadowPath];
//}
//+(void)setDropShadowOnTextField:(UITextField *)view shadowOffset:(CGSize)shadowOffset
//{
//    view.borderStyle = UITextBorderStyleNone;
//    view.layer.masksToBounds = NO;
//    view.layer.shadowColor = [UIColor blackColor].CGColor;
//    view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    view.layer.shadowOpacity = 0.5f;
//    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
//    view.layer.cornerRadius = 4;
//    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:3.];
//    view.layer.shadowPath = shadowPath.CGPath;
//    
//}
//#pragma mark -
//#pragma mark File Managers
//#pragma mark -
//+(BOOL)writeTextToFileAtPath:(NSString *)fileName stringToWrite:(NSString *)stringToWrite
//{
//    NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//    
//    NSString *textPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//    NSError *error = nil;
//    
//    [stringToWrite writeToFile:textPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    if (error != nil)
//    {
//        NSLog(@"There was an error in creating a file : %@", [error description]);
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//
//+(NSString *)readTextFileAtPath:(NSString *)fileName
//{
//    if ([UtilityFunctions isFileExist:fileName])
//    {
//        NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//        
//        NSString *textPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//        
//        NSError *error = nil;
//        
//        NSString *str = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:&error];
//        
//        if (error != nil)
//        {
//            NSLog(@"There was an error: %@", [error description]);
//            return nil;
//        }
//        else
//        {
//            return str;
//        }
//    }
//    else
//    {
//        return nil;
//    }
//}
//
//+(NSData *)getFileOnPath:(NSString *)fileName
//{
//    if ([UtilityFunctions isFileExist:fileName])
//    {
//        NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//        
//        NSString *textPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//        
//        NSError *error = nil;
//        
//        NSData *fileData = [NSData dataWithContentsOfFile:textPath options:NSDataReadingMappedIfSafe error:&error];
//        
//        if (error != nil)
//        {
//            NSLog(@"There was an error: %@", [error description]);
//            return nil;
//        }
//        else
//        {
//            return fileData;
//        }
//    }
//    else
//    {
//        return nil;
//    }
//}
//
//
//+(BOOL)saveFileOnPath:(NSString *)fileName filePath:(NSString *)filePath fileData:(NSData *)dataToSave
//{
//    if (![self isFileExist:filePath])
//    {
//        [self createDirectoryInsideDocumentFolder:filePath];
//    }
//    
//    NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//    
//    NSString *textPath = [[documentsDirectory stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
//    
//    NSError *error = nil;
//    
//    [dataToSave writeToFile:textPath options:NSDataWritingFileProtectionNone error:&error];
//    
//    if (error != nil)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//
//
//+(BOOL)deleteFileByFileName:(NSString *)fileName
//{
//    NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//    
//    return [UtilityFunctions deleteFileAtPath:documentsDirectory filePath:fileName];
//}
//
//
//+(BOOL)deleteFileAtPath:(NSString *)fileName filePath:(NSString *)filePath
//{
//    NSString *fullPath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
//    
//    NSFileManager *fileManager =[NSFileManager defaultManager];
//    
//    if(![fileManager fileExistsAtPath:fullPath] )
//    {
//        return YES;
//    }
//    else
//    {
//        return [fileManager removeItemAtPath:fullPath error:NULL];
//    }
//}
//
//+(BOOL)isFileExist:(NSString *)fileName
//{
//    NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//    
//    NSString *textPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//    NSFileManager *fileManager =[NSFileManager defaultManager];
//    
//    if ([fileManager fileExistsAtPath:textPath])
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}
//
//
//+(BOOL)createDirectoryAtPath:(NSString *)path
//{
//    NSError *error = nil;
//    
//    [[NSFileManager defaultManager] createDirectoryAtPath:path
//                              withIntermediateDirectories:NO
//                                               attributes:nil
//                                                    error:&error];
//    if (error != nil)
//    {
//        NSLog(@"There was an error in creating a folder : %@", [error description]);
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//
//
//+(BOOL)createDirectoryInsideDocumentFolder:(NSString *)newDirectoryName
//{
//    NSString *documentsDirectory = [UtilityFunctions getDocumentDirectoryPath];
//    
//    return [self createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:newDirectoryName]];
//}
//
//
//+(NSString *)getDocumentDirectoryPath
//{
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    return [pathArray objectAtIndex:0];
//}
//
//
//+(void)setApplicationBadgeNumber:(NSInteger)number
//{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:number];
//}
//+(void)increaseApplicationBadgeNumberByOne
//{
//    NSInteger count = [[UIApplication sharedApplication] applicationIconBadgeNumber];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count+1];
//}
//
//
//
//+ (UIImage*)imageWithBorderFromImage:(UIImage*)source
//{
//    CGSize size = [source size];
//    UIGraphicsBeginImageContext(size);
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 178/255, 190/255, 214/255, 1.0);
//    CGContextStrokeRect(context, rect);
//    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return testImg;
//}
//
//
//#pragma mark -
//#pragma mark NSString to MD5
//#pragma mark -
//+ (NSString *)getMD5String :(NSString *)string
//{
//    const char *cstr = [string UTF8String];
//    unsigned char result[16];
//    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
//    
//    return [NSString stringWithFormat:
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]];
//}
//
//#pragma mark -
//#pragma mark setUpWidthOfHomeMenuButton
//#pragma mark -
//
//+(void)setUpWidthOfHomeMenuButton:(UIButton*)button
//{
//    if (button)
//    {
//        CGSize size;
//        
//        CGRect expectedLabelSize = [button.titleLabel.text boundingRectWithSize:button.frame.size options:NSStringDrawingUsesFontLeading
//                                                                     attributes:@{
//                                                                                  NSFontAttributeName: button.titleLabel.font
//                                                                                  }
//                                                                        context:nil];
//        
//        size = expectedLabelSize.size;
//        
//        (size.height>200)?[button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, 200, button.frame.size.height)]:[button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, size.width, button.frame.size.height)];
//        
//        [button setImageEdgeInsets:UIEdgeInsetsMake(2,button.frame.size.width+23, 0, 0)];
//        
//    }
//    
//}
//+(void)setUpWidthOfLabel:(UILabel*)label
//{
//    CGSize size;
//    
//    CGRect expectedLabelSize = [label.text boundingRectWithSize:label.frame.size options:NSStringDrawingUsesFontLeading
//                                                     attributes:@{
//                                                                  NSFontAttributeName: label.font
//                                                                  }
//                                                        context:nil];
//    size = expectedLabelSize.size;
//    
//    [label setTextAlignment:NSTextAlignmentCenter];
//    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width+10, label.frame.size.height)];
//    
//}
//+(void)setUpWidthOfLabelLeftAlignment:(UILabel*)label
//{
//    
//    CGSize size;
//    CGRect expectedLabelSize = [label.text boundingRectWithSize:label.frame.size options:NSStringDrawingUsesFontLeading
//                                                     attributes:@{
//                                                                  NSFontAttributeName: label.font
//                                                                  }
//                                                        context:nil];
//    
//    size = expectedLabelSize.size;
//    [label setTextAlignment:NSTextAlignmentLeft];
//    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width+10, label.frame.size.height)];
//}
//+(CGSize)getWidthOfLabel:(UILabel*)label
//{
//    
//    CGSize size;
//    CGRect expectedLabelSize = [label.text boundingRectWithSize:label.frame.size options:NSStringDrawingUsesFontLeading
//                                                     attributes:@{
//                                                                  NSFontAttributeName: label.font
//                                                                  }
//                                                        context:nil];
//    
//    size = expectedLabelSize.size;
//    
//    return size;
//    
//}
//+(void)setUpWidthOfLabel:(UILabel*)label withAlignment:(NSTextAlignment)alignment
//{
//    CGRect expectedLabelSize = [label.text boundingRectWithSize:label.frame.size options:NSStringDrawingUsesFontLeading
//                                                     attributes:@{
//                                                                  NSFontAttributeName: label.font
//                                                                  }
//                                                        context:nil];
//    
//    CGSize size = expectedLabelSize.size;
//    [label setTextAlignment:NSTextAlignmentRight];
//    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width+10, label.frame.size.height)];
//    
//}
//
//+(NSString *)getCommaSeperatedFormattedPrice:(double)price
//{
//    double calculatedPrice = price;
//    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    //[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//    [formatter setMaximumFractionDigits:2];
//    [formatter setGroupingSize:3];
//    [formatter setAlwaysShowsDecimalSeparator:YES];
//    [formatter setUsesGroupingSeparator:YES];
//    
//    NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithDouble:calculatedPrice]];
//    NSUInteger length = [formattedString length];
//    if ((length > 0) && [[formattedString substringFromIndex:length - 1] isEqualToString:@"."])
//    {
//        NSRange lastComma = [formattedString rangeOfString:@"." options:NSBackwardsSearch];
//        
//        if(lastComma.location != NSNotFound) {
//            formattedString = [formattedString stringByReplacingCharactersInRange:lastComma
//                                                                       withString: @".00"];
//        }
//    }
//    
//    
//    return formattedString;
//}
//
//
//#pragma mark -
//#pragma mark Notifications
//#pragma mark -
//
//+ (void)updateJobCountOnMenu:(NSInteger)count
//{
//    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
//    [userInfo setValue:[NSNumber numberWithInteger:count] forKey:@""];
//    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
//    [nc postNotificationName:@"" object:self userInfo:userInfo];
//}
//+ (void)updateMessageCountOnMenu:(NSInteger)count
//{
//    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
//    [userInfo setValue:[NSNumber numberWithInteger:count] forKey:@""];
//    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
//    [nc postNotificationName:@"" object:self userInfo:userInfo];
//}
//
//+(CGSize)getSizeOfString:(NSString *)string withTextView:(UITextView*)textView
//{
//    
//    CGSize size;
//    CGRect expectedLabelSize = [string boundingRectWithSize:textView.frame.size options:NSStringDrawingUsesFontLeading
//                                                 attributes:@{
//                                                              NSFontAttributeName: textView.font
//                                                              }
//                                                    context:nil];
//    
//    size = expectedLabelSize.size;
//    return size;
//    
//}
//
//+(CGFloat)getHeightOfString:(NSString *)string withLabel:(UILabel*)lbl
//{
//    
//    CGSize size;
//    CGRect expectedLabelSize = [string boundingRectWithSize:CGSizeMake(lbl.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading
//                                                 attributes:@{
//                                                              NSFontAttributeName: lbl.font
//                                                              }
//                                                    context:nil];
//    
//    size = expectedLabelSize.size;
//    return size.height;
//    
//}
//
//+ (CGFloat)measureHeightOf:(NSString *)string withTextView:(UITextView *)textView
//{
//    if ([textView respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
//    {
//        // This is the code for iOS 7. contentSize no longer returns the correct value, so
//        // we have to calculate it.
//        //
//        // This is partly borrowed from HPGrowingTextView, but I've replaced the
//        // magic fudge factors with the calculated values (having worked out where
//        // they came from)
//        
//        CGRect frame = textView.bounds;
//        
//        // Take account of the padding added around the text.
//        
//        UIEdgeInsets textContainerInsets = textView.textContainerInset;
//        UIEdgeInsets contentInsets = textView.contentInset;
//        
//        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
//        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
//        
//        frame.size.width -= leftRightPadding;
//        frame.size.height -= topBottomPadding;
//        
//        NSString *textToMeasure = string;
//        if ([textToMeasure hasSuffix:@"\n"])
//        {
//            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
//        }
//        
//        // NSString class method: boundingRectWithSize:options:attributes:context is
//        // available only on ios7.0 sdk.
//        
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
//        
//        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
//        
//        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
//                                                  options:NSStringDrawingUsesLineFragmentOrigin
//                                               attributes:attributes
//                                                  context:nil];
//        
//        CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
//        return measuredHeight;
//    }
//    else
//    {
//        return textView.contentSize.height;
//    }
//}
//+ (CGFloat)measureWidthOf:(NSString *)string withTextView:(UITextView *)textView
//{
//    if ([textView respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)])
//    {
//        // This is the code for iOS 7. contentSize no longer returns the correct value, so
//        // we have to calculate it.
//        //
//        // This is partly borrowed from HPGrowingTextView, but I've replaced the
//        // magic fudge factors with the calculated values (having worked out where
//        // they came from)
//        
//        CGRect frame = textView.bounds;
//        
//        // Take account of the padding added around the text.
//        
//        UIEdgeInsets textContainerInsets = textView.textContainerInset;
//        UIEdgeInsets contentInsets = textView.contentInset;
//        
//        CGFloat leftRightPadding = textContainerInsets.left + textContainerInsets.right + textView.textContainer.lineFragmentPadding * 2 + contentInsets.left + contentInsets.right;
//        CGFloat topBottomPadding = textContainerInsets.top + textContainerInsets.bottom + contentInsets.top + contentInsets.bottom;
//        
//        frame.size.width -= leftRightPadding;
//        frame.size.height -= topBottomPadding;
//        
//        NSString *textToMeasure = string;
//        if ([textToMeasure hasSuffix:@"\n"])
//        {
//            textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
//        }
//        
//        // NSString class method: boundingRectWithSize:options:attributes:context is
//        // available only on ios7.0 sdk.
//        
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
//        
//        NSDictionary *attributes = @{ NSFontAttributeName: textView.font, NSParagraphStyleAttributeName : paragraphStyle };
//        
//        CGRect size = [textToMeasure boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
//                                                  options:NSStringDrawingUsesLineFragmentOrigin
//                                               attributes:attributes
//                                                  context:nil];
//        
//        CGFloat measuredHeight = ceilf(CGRectGetWidth(size) + leftRightPadding);
//        return measuredHeight;
//    }
//    else
//    {
//        return textView.contentSize.width;
//    }
//}
//
//
//#pragma mark -
//#pragma mark Session Save
//#pragma mark -
//
//+(void)saveSessionToDisk:(NSDictionary*)Session
//{
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]  initWithDictionary:Session];
//    NSError  *error;
//    NSData* archiveData = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"SavedSession.plist"];
//    [archiveData writeToFile:fullPath options:NSDataWritingAtomic error:&error];
//}
//+(NSDictionary*)loadSessionFromDisk
//{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"SavedSession.plist"];
//    NSLog(@"%@",fullPath);
//    NSFileManager *fileManager =[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:fullPath])
//    {
//        NSMutableDictionary *dict = nil;
//        @try
//        {
//            NSData *archiveData = [NSData dataWithContentsOfFile:fullPath];
//            dict = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
//            if ([dict count] > 0)
//            {
//                return dict;
//            }
//            else
//                return nil;
//        }
//        @catch (NSException * e)
//        {
//        }
//        @finally
//        {
//        }
//    }
//    else
//        return nil;
//}
//+(int)timeDifference:(NSDate *)currentDate fireDate:(NSDate*)fireDate
//{
//    
//    NSTimeInterval distanceBetweenDates = [currentDate timeIntervalSinceDate:fireDate];
//    return distanceBetweenDates;
//    //    double secondsInAnHour = 3600;
//    //    NSInteger hours = distanceBetweenDates / secondsInAnHour;
//    //    return hours ;
//    
//}
//
////iOS 8
//
//+(UIWindow*)getKeyWindow {
//    for (UIWindow *window in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
//        if ([window class] == [UIWindow class]) {
//            // do whatever you want with the window object
//            return window;
//        }
//    }
//    return nil;
//}
//
//+ (NSMutableAttributedString *) makeAttributedStringWithArrayOfAttributes:(NSArray *)array
//{
//    NSString *completeText = @"";
//    NSDictionary *firstAttribute = nil;
//    for (NSDictionary *dictionary in array) {
//        completeText = [NSString stringWithFormat:@"%@%@", completeText,[dictionary objectForKey:@"text"]];
//        firstAttribute = [array firstObject];
//    }
//    
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:completeText attributes:firstAttribute];
//    for (NSDictionary *dictionary in array) {
//        NSString *text = [dictionary objectForKey:@"text"];
//        NSDictionary *attributes = [dictionary objectForKey:@"attribute"];
//        NSRange textRange = [completeText rangeOfString:text];
//        
//        [attributedText setAttributes:attributes
//                                range:textRange];
//    }
//    
//    return attributedText;
//}
//
//+ (BOOL)connectedToNetwork {
//    // Create zero addy
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    Boolean didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    if (!didRetrieveFlags)
//    {
//        NSLog(@"Error. Could not recover network reachability flags");
//        return NO;
//    }
//    
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
//    
//    NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"];
//    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:self];
//#pragma clang diagnostic pop
//    
//    
//    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
//}
//
//+ (void) saveNSObjectInNSUserDefault:(NSObject*) object forKey:(NSString *)key
//{
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object ];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//+ (void) removeNSObjectInNSUserDefaultforKey:(NSString *)key
//{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//+ (NSObject *) getNSObjectFromNSUserDefaultforKey:(NSString *)key
//{
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    NSObject *object = (NSObject *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
//    return object;
//}
//
//#pragma mark - Add/Remove UIRefreshControl to TableView -
//
//+ (UIRefreshControl *)refreshControlWithBackgroundColor:(UIColor *)bgColor andSelector:(SEL)selector{
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc ] init];
//    refreshControl.backgroundColor = bgColor;
//    refreshControl.tintColor  = [[UIApplication sharedApplication].keyWindow tintColor] ;
//    [refreshControl addTarget:self action:@selector(selector) forControlEvents:UIControlEventValueChanged];
//    
//    return refreshControl;
//}
//
//+ (void)hideRefreshControl:(UIRefreshControl *)refreshControl withTextColor:(UIColor *)color{
//    if  (refreshControl) {
//        NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MMM d, h:mm a"];
//        NSString *title = [NSString stringWithFormat:@"Last update: %@" , [formatter stringFromDate:[NSDate date]]];
//        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
//        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
//        refreshControl.attributedTitle  = attributedTitle;
//        
//        [refreshControl endRefreshing];
//    }
//}
//
//+ (void)zoomMapViewForAllAnnotations:(MKMapView*)aMapView
//{
//    if ([aMapView.annotations count] == 0)
//        return;
//    
//    //Establish Max/Min
//    CLLocationCoordinate2D topLeftCoord;
//    topLeftCoord.latitude = -90;
//    topLeftCoord.longitude = 180;
//    
//    CLLocationCoordinate2D bottomRightCoord;
//    bottomRightCoord.latitude = 90;
//    bottomRightCoord.longitude = -180;
//    
//    //Iterate over all annotations and find bounds
//    for (MKPointAnnotation* annotation in aMapView.annotations) {
//        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
//        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
//        
//        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
//        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
//    }
//    
//    //Set region
//    MKCoordinateRegion region;
//    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
//    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
//    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 2; // Add a little extra space on the sides
//    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 2; // Add a little extra space on the sides
//    
//    region = [aMapView regionThatFits:region];
//    [aMapView setRegion:region animated:YES];
//}
//
//+ (void)centreMapViewAtCoordinate :(CLLocation*)location andMapView:(MKMapView*) mapView {
//    @try {
//        CLLocationCoordinate2D center = location.coordinate;
//        [mapView setCenterCoordinate:center animated:YES];
//        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(center, 2000, 2000);
//        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
//        [mapView setRegion:adjustedRegion animated:YES];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"NSException : %@",exception.description);
//    }
//    @finally {
//        
//    }
//}
//+ (void)zoomToPolyLine: (MKMapView*)map polyLine:(MKPolyline*)polyLine animated: (BOOL)animated
//{
//    MKPolygon* polygon = [MKPolygon polygonWithPoints:polyLine.points count:polyLine.pointCount];
//
//    [map setVisibleMapRect:[polygon boundingMapRect] edgePadding:UIEdgeInsetsMake(100., 100.0, 100.0, 100.0) animated:animated];
//    
//}
//+ (void)showAlertLocationDisabled{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString( @"Location Service Disabled", @"" ) message:NSLocalizedString( @"To re-enable, please go to Settings and turn on Location Service for this app.", @"" ) preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"" ) style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", @"" ) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
//    }];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:settingsAction];
//    
//    [[[UtilityFunctions getKeyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
//}
//+ (void)updateLocation {
////    __block INTULocationRequestID requestId = [[INTULocationManager sharedInstance] subscribeToLocationUpdatesWithDesiredAccuracy:INTULocationAccuracyNeighborhood block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
////        if (status == INTULocationStatusSuccess) {
////            [[INTULocationManager sharedInstance] cancelLocationRequest:requestId];
////            //            return currentLocation;
////        }
////        else if (status == INTULocationStatusTimedOut) {
////        }
////        else if (status == INTULocationStatusServicesDisabled) {
////            [[INTULocationManager sharedInstance] requestLocationAccess];
////        }
////        else if (status == INTULocationStatusServicesDenied){
////            [UtilityFunctions showAlertLocationDisabled];
////        }
////        else {
////        }
////    }];
//}
//
///**
// *  Call An API.
// *
// *  @param link        path
// *  @param params      dictionary
// *  @param responseApi UIApiResponse
// */
//+ (void)callPutAPI:(NSString *)link andParams:(NSDictionary*)params andResponse :(UFAPIResponse)responseApi{
////    [SVProgressHUD show];
////    [[SVHTTPClient sharedClient] setValue:[[UserManager currentUser] authToken] forHTTPHeaderField:@"X-API-KEY"];
////    [[SVHTTPClient sharedClient] PUT:link parameters:params completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
////        [SVProgressHUD dismiss];
////        APIResponse *apiResponse = [APIResponse handleResponse:response error:error];
////        responseApi(apiResponse);
////    }];
//}
//
//
//
//+( NSUInteger) getTimeForTravelBetween:(CLLocation*) source andDestination:(CLLocation*)destination {
//    CLLocationDistance distanceMeters = [source distanceFromLocation:destination];  //      distance is expressed in meters
//    CLLocationDistance kilometers = distanceMeters / 1000.0; //convert to KiloMeters
//    float timeOfRide = kilometers/ 28.8; //40kmph
////    NSString * leftNumber  = [NSString stringWithFormat:@"%0.0f", truncf(timeOfRide)];
////    NSString * rightNumber = [[NSString stringWithFormat:@"%0.2f", fmodf(timeOfRide, 1.0)] substringFromIndex:2];
////    NSLog(@"'%@' '%@'", leftNumber, rightNumber);
////    NSInteger hour = [leftNumber integerValue];
//    NSInteger minutes = timeOfRide * 60;
////    NSInteger minutes2 = [rightNumber integerValue] * 0.6;
////    minutes2 += minutes;
//    if (minutes == 0 ) {
//        minutes = 1;
//    }
//    return minutes;
//}
//+( CGFloat) getDistinceInKMBetween:(CLLocation*) source andDestination:(CLLocation*)destination {
//    CLLocationDistance distanceMeters = [source distanceFromLocation:destination];  //      distance is expressed in meters
//    CLLocationDistance kilometers = distanceMeters / 1000.0;
//    return kilometers;
//}
//@end
