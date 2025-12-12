#import "NSString+Utilities.h"
#import "NSDictionary+Utilities.h"

@implementation NSString (Extensions)


- (NSNumber*)utilities_stringToNSNumber
{
	NSNumberFormatter* tmpFormatter = [[NSNumberFormatter alloc] init];
	[tmpFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber* theNumber = [tmpFormatter numberFromString:self];
	return theNumber;
}

- (BOOL)utilities_isEmpty {
    if ([self length] <= 0 || self == (id)[NSNull null] || self == nil) {
        return YES;
    } 
    return NO;
}

- (BOOL)utilities_stringContainsSubString:(NSString *)subString
{
    NSRange aRange = [self rangeOfString:subString];
    if (aRange.location == NSNotFound)
    {
        return NO;
    }
    
    return YES;
}

- (NSString*)utilities_stringByReplacingStringsFromDictionary:(NSDictionary*)dict {
    NSMutableString* string = [self mutableCopy];
    for (NSString* target in dict) {
        [string replaceOccurrencesOfString:target withString:[dict objectForKey:target] options:0 range:NSMakeRange(0, [string length])];
    }
    return string;
}


//
//  NSString+EPPZKit.m
//  EPPZKit
//
//  Created by Borbás Geri on 1/19/12.
//  Copyright (c) 2013 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

-(BOOL)utilities_isEqualToStringIgnoringCase:(NSString*) string
{ return [self.lowercaseString isEqualToString:string.lowercaseString]; }

-(NSString*)utilities_firstFiveCharacter
{
    if (self.length <= 5) return self;
    return [NSString stringWithFormat:@"%@...", [self substringWithRange:NSMakeRange(0, 5)]];
}

-(NSString*)utilities_firstTenCharacter
{
    if (self.length <= 10) return self;
    return [NSString stringWithFormat:@"%@...", [self substringWithRange:NSMakeRange(0, 10)]];
}


-(NSString*)utilities_urlEncode
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	NSString *result = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    #pragma clang diagnostic pop
	return result;
}

-(NSString*)utilities_urlDecode
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (__bridge NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                       (CFStringRef) self,
                                                                                       CFSTR(""),
                                                                                       kCFStringEncodingUTF8);
    #pragma clang diagnostic pop
}

-(NSDate*)utilities_dateValue
{
    __block NSDate *detectedDate;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
    [detector enumerateMatchesInString:self
                               options:kNilOptions
                                 range:NSMakeRange(0, [self length])
                            usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     { detectedDate = result.date; }];
    return detectedDate;
}


#pragma mark - (NSStringDrawing) compatibility

-(CGSize)_sizeWithFont:(UIFont*) font
{
    // Checks.
    if (font == nil) return CGSizeZero;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    return [self sizeWithAttributes:@{ NSFontAttributeName : font}];
#else
    return [self sizeWithFont:font];
#endif
}


#pragma mark - (UIStringDrawing) compatibility

-(void)_drawAtPoint:(CGPoint) point withFont:(UIFont*) font foregroundColor:(UIColor*) color
{
    // Checks.
    if (font == nil) return;
    if (color == nil) color = [UIColor clearColor];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    [self drawAtPoint:point withAttributes:@{
                                             NSFontAttributeName : font,
                                             NSForegroundColorAttributeName : color
                                             }];
    
#else
    
    [color setFill];
    [self drawAtPoint:point withFont:font];
    
#endif
}

-(void)_drawInRect:(CGRect) frame withFont:(UIFont*) font foregroundColor:(UIColor*) color
{
    // Checks.
    if (font == nil) return;
    if (color == nil) color = [UIColor clearColor];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    NSMutableParagraphStyle *truncate = [NSMutableParagraphStyle new];
    [truncate setLineBreakMode:NSLineBreakByTruncatingTail];
    [self drawInRect:frame withAttributes:@{
                                            NSFontAttributeName : font,
                                            NSForegroundColorAttributeName : color,
                                            NSParagraphStyleAttributeName : truncate
                                            }];
    
#else
    
    [color setFill];
    [self drawInRect:frame withFont:font lineBreakMode:NSLineBreakByTruncatingTail];
    
#endif
}



@end


@implementation NSString (Extension)

/**
 Given an integer value, returns the corresponding string.
 
 @author DJS 2008-07.
 */

+ (NSString *)utilities_stringWithIntegerValue:(NSInteger)value;
{
#if TARGET_OS_IPHONE
    return [self stringWithFormat:@"%ld", (long)value];
#else
    return [self stringWithFormat:@"%ld", value];
#endif
}

/**
 Given a CGFloat value and the number of decimal places to represent it as, returns the corresponding string.
 
 @author DJS 2005-04.
 */

+ (NSString *)utilities_stringWithFloatValue:(CGFloat)value places:(NSInteger)places
{
#if TARGET_OS_IPHONE
    NSString *format = [self stringWithFormat:@"%%.%ldf", (long)places];
#else
    NSString *format = [self stringWithFormat:@"%%.%ldf", places];
#endif
    
    return [self stringWithFormat:format, value];
}

/**
 Given a CGFloat value, returns the corresponding string, with as many non-zero digits in the decimal portion as appropriate.
 
 @author DJS 2013-01.
 */

+ (NSString *)utilities_stringWithTruncatedFloatValue:(CGFloat)value;
{
    NSMutableString *mutie = [[self stringWithFormat:@"%f", value] mutableCopy];
    
    while ([mutie hasSuffix:@"0"])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    if ([mutie hasSuffix:@"."])
        [mutie deleteCharactersInRange:NSMakeRange([mutie length] - 1, 1)];
    
    return mutie;
}

/**
 Given an NSInteger value, if it is zero, the zero string is returned; if one, the singular string is returned; otherwise the plural string is returned.
 */

+ (NSString *)utilities_stringWithIntegerValue:(NSInteger)value
                                      zero:(NSString *)zero
                                  singluar:(NSString *)singular
                                    plural:(NSString *)plural;
{
    if (!value && zero)
        return zero;
    else if ((value == 1 || value == -1) && singular)
        return singular;
    else
        return plural;
}

/**
 Given a CGFloat value, if it is zero, the zero string is returned; if exactly one, the singular string is returned; otherwise the plural string is returned.
 
 @author DJS 2008-04.
 @version DJS 2014-01: changed to treat -1.0 as singular too.
 */

+ (NSString *)utilities_stringWithFloatValue:(CGFloat)value
                                    zero:(NSString *)zero
                                singluar:(NSString *)singular
                                  plural:(NSString *)plural;
{
    if (!value && zero)
        return zero;
    else if ((value == 1.0 || value == -1.0) && singular)
        return singular;
    else
        return plural;
}

/**
 Given a time interval, returns a string with that interval and appropriate time units.  This might be better as a NSFormatter subclass for time intervals?
 
 @author DJS 2009-09.
 */

+ (NSString *)utilities_stringWithTimeInterval:(NSTimeInterval)seconds;
{
    return [self utilities_stringWithTimeInterval:seconds suffix:nil];
}

/**
 Given a time interval and suffix (e.g. "ago"), returns a string with that interval, appropriate time units, and the suffix, e.g. "3.2 minutes ago".  This might be better as a NSFormatter subclass for time intervals?
 
 @author DJS 2009-09.
 */

+ (NSString *)utilities_stringWithTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;
{
    NSString *value;
    CGFloat minutes = seconds / 60.0;
    CGFloat hours = minutes / 60.0;
    CGFloat days = hours / 24.0;
    CGFloat weeks = days / 7.0;
    CGFloat months = days / 31.0;
    CGFloat years = months / 12.0;
    
    if (years >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", years, [NSString utilities_stringWithFloatValue:years zero:nil singluar:@"year" plural:@"years"]];
    else if (months >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", months, [NSString utilities_stringWithFloatValue:months zero:nil singluar:@"month" plural:@"months"]];
    else if (weeks >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", weeks, [NSString utilities_stringWithFloatValue:weeks zero:nil singluar:@"week" plural:@"weeks"]];
    else if (days >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", days, [NSString utilities_stringWithFloatValue:days zero:nil singluar:@"day" plural:@"days"]];
    else if (hours >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", hours, [NSString utilities_stringWithFloatValue:hours zero:nil singluar:@"hour" plural:@"hours"]];
    else if (minutes >= 1.0)
        value = [NSString stringWithFormat:@"%.1f %@", minutes, [NSString utilities_stringWithFloatValue:minutes zero:nil singluar:@"minute" plural:@"minutes"]];
    else
        value = [NSString stringWithFormat:@"%.1f %@", seconds, [NSString utilities_stringWithFloatValue:seconds zero:nil singluar:@"second" plural:@"seconds"]];
    
    if (suffix.length)
        value = [value stringByAppendingFormat:@" %@", suffix];
    
    return value;
}

/**
 Given a time interval and suffix (e.g. "ago"), returns a string with that interval (rounded to the nearest whole number), appropriate time units, and the suffix, e.g. "3 minutes ago".  This might be better as a NSFormatter subclass for time intervals?
 
 @author DJS 2009-09.
 */

+ (NSString *)utilities_stringWithRoundedTimeInterval:(NSTimeInterval)seconds suffix:(NSString *)suffix;
{
    NSString *value;
    CGFloat minutes = seconds / 60.0;
    CGFloat hours = minutes / 60.0;
    CGFloat days = hours / 24.0;
    CGFloat weeks = days / 7.0;
    CGFloat months = days / 31.0;
    CGFloat years = months / 12.0;
    
    if (years >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(years), [NSString utilities_stringWithIntegerValue:rintf(years) zero:nil singluar:@"year" plural:@"years"]];
    else if (months >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(months), [NSString utilities_stringWithIntegerValue:rintf(months) zero:nil singluar:@"month" plural:@"months"]];
    else if (weeks >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(weeks), [NSString utilities_stringWithIntegerValue:rintf(weeks) zero:nil singluar:@"week" plural:@"weeks"]];
    else if (days >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(days), [NSString utilities_stringWithIntegerValue:rintf(days) zero:nil singluar:@"day" plural:@"days"]];
    else if (hours >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(hours), [NSString utilities_stringWithIntegerValue:rintf(hours) zero:nil singluar:@"hour" plural:@"hours"]];
    else if (minutes >= 1.0)
        value = [NSString stringWithFormat:@"%.0f %@", rintf(minutes), [NSString utilities_stringWithIntegerValue:rintf(minutes) zero:nil singluar:@"minute" plural:@"minutes"]];
    else
        value = [NSString stringWithFormat:@"%.0f %@", rintf(seconds), [NSString utilities_stringWithIntegerValue:rintf(seconds) zero:nil singluar:@"second" plural:@"seconds"]];
    
    if (suffix.length)
        value = [value stringByAppendingFormat:@" %@", suffix];
    
    return value;
}

/**
 Given an integer value representing a time in seconds, and the appropriate words for minutes and seconds in singular and plural, this returns a string expressing this time interval, e.g. @"1 minute 37 seconds".  Pass nil for the minutes or seconds parameter pairs to exclude those units, e.g. passing nil for secondSingular and secondsPlural will result in just "1 minute".  If both are wanted, and one is zero, it is omitted [if different behavor is desired in the future, add a parameter to indicate that; don't change that functionality].  Similar methods can be added to include the option of hours, etc, as needed.
 
 @author DJS 2003-07.
 */

+ (NSString *)utilities_stringWithSeconds:(NSInteger)seconds
                       minuteSingular:(NSString *)minuteSingular
                        minutesPlural:(NSString *)minutesPlural
                       secondSingular:(NSString *)secondSingular
                        secondsPlural:(NSString *)secondsPlural
{
    NSString *minutesString = nil;
    NSString *secondsString = nil;
    NSString *timeString = nil;
    NSInteger minutes = seconds / 60;
    
    BOOL wantSeconds = (secondSingular && secondsPlural);
    BOOL wantMinutes = (minuteSingular && minutesPlural);
    
    if (wantMinutes)
    {
        seconds = seconds % 60;
        
#if TARGET_OS_IPHONE
        minutesString = [self stringWithFormat:@"%ld %@", (long)minutes,
                         [self utilities_stringWithIntegerValue:minutes zero:nil singluar:minuteSingular plural:minutesPlural]];
#else
        minutesString = [self stringWithFormat:@"%ld %@", minutes,
                         [self utilities_stringWithIntegerValue:minutes zero:nil singluar:minuteSingular plural:minutesPlural]];
#endif
    }
    
    if (wantSeconds)
        secondsString = [self stringWithFormat:NSLocalizedString(@"%ld %@", @"Seconds remaining"), (long)seconds,
                         [self utilities_stringWithIntegerValue:seconds zero:nil singluar:secondSingular plural:secondsPlural]];
    
    if (minutes && seconds && wantSeconds && wantMinutes)
        timeString = [NSString stringWithFormat:@"%@ %@", minutesString, secondsString];
    else if (minutes || !wantSeconds)
        timeString = minutesString;
    else
        timeString = secondsString;
    
    return timeString;
}

/**
 Given an NSInteger value, returns it as a string.  If the length of the resulting string is less than minLength, it is padded with the specified padding characters, on the left or right as requested.  [Note: currently the padding is assumed to be a single character, but support for multi-characters could be added in the future.]
 */

+ (NSString *)utilities_stringWithIntegerValue:(NSInteger)value minimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;
{
#if TARGET_OS_IPHONE
    return [[self stringWithFormat:@"%ld", (long)value] utilities_stringWithMinimumLength:minLength paddedWith:padding padLeft:padLeft];
#else
    return [[self stringWithFormat:@"%ld", value] utilities_stringWithMinimumLength:minLength paddedWith:padding padLeft:padLeft];
#endif
}

/**
 Given an NSInteger value, returns it as a string with the specified number of digits.  If there are less digits in the number, it is padded with leading zeroes.  If there are more, it is truncated to that number of digits.  Note that this is equivalent to the somewhat shorter, but less intuitive, +[NSString stringWithFormat:@"%0.4d", value], where the 4 is replaced by the number of digits, except that that approach won't truncate a longer number.
 
 @author DJS 2004-03.
 */

+ (NSString *)utilities_stringWithLeadingZeroesForIntegerValue:(NSInteger)value digits:(NSInteger)digits;
{
#if TARGET_OS_IPHONE
    return [[self stringWithFormat:@"%0.10ld", (long)value] utilities_right:digits];
#else
    return [[self stringWithFormat:@"%0.10ld", value] utilities_right:digits];
#endif
}

/**
 Given a value in bytes, returns it as a string with the suffix " bytes", " KB", " MB", or " GB", as appropriate.
 */

+ (NSString *)utilities_stringAsBytesWithInteger:(NSInteger)bytes;
{
    NSString *temp;
    CGFloat kilobyte = 1024.0;
    CGFloat megabyte = kilobyte * kilobyte;
    CGFloat gigabyte = megabyte * kilobyte;
    
    if (bytes == 0)
        temp = NSLocalizedStringFromTable(@"Zero KB", @"ExtensionOpen", @"Zero Kilobytes");
    else if (bytes >= gigabyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f GB", @"ExtensionOpen", @"Gigabytes"), bytes / gigabyte];
    else if (bytes >= megabyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f MB", @"ExtensionOpen", @"Megabytes"), bytes / megabyte];
    else if (bytes >= kilobyte)
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%.1f KB", @"ExtensionOpen", @"Kilobytes"), bytes / kilobyte];
    else
        temp = [self stringWithFormat:NSLocalizedStringFromTable(@"%ld bytes", @"ExtensionOpen", @"Bytes"), (long)bytes];
    
    return temp;
}

/**
 If the keyword is a valid non-empty string, returns a string containing the prefix, keyword, and suffix (the prefix and/or suffix may be nil if desired).  Otherwise, if the alternative is a valid non-empty string, returns that instead.  If both the keyword and alternative are nil, nil is returned, so if you want a valid string, pass @"" for at least the alternative.
 
 @author DJS 2004-03.
 */

+ (NSString *)utilities_stringWithPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;
{
    if (!keyword && !alternative)
        return nil;
    
    NSMutableString *retString = [NSMutableString string];
    
    [retString utilities_appendPrefix:prefix keyword:keyword suffix:suffix or:alternative];
    
    return retString;
}

/**
 Gotta be one of the shortest method names!  If preferred is not nil, that object is returned, otherwise self is returned.  Useful to provide an optional string, e.g. [@"never" or:someDateObject].
 
 @author DJS 2002.
 */

- (id)utilities_or:(id)preferred;
{
    if (preferred)
        return preferred;
    else
        return self;
}

/**
 Given a string with two or more alternatives separated by " | ", returns the string at the specified index.  Can be used as a horribly inefficient variation on bool ? str1 : str2, or to get one of several values based on an integer.  Particularly useful with localized strings, since several can be combined into one string.  If the index is greater than the number of alternatives, an empty string is returned.
 
 @author DJS 2010-10.
 */

- (NSString *)utilities_indexedBy:(NSUInteger)idx;
{
    NSArray *alternatives = [self componentsSeparatedByString:@" | "];
    
    if (idx < [alternatives count])
        return alternatives[idx];
    else
        return @"";
}

/**
 Returns YES if the string is non-empty, i.e. not nil and not @"".
 
 @author DJS 2005-03.
 */

- (BOOL)utilities_containsSomething
{
    return ([self length] > 0);
}

/**
 Returns YES if the subString is within the receiver, otherwise NO.  [Note: can easily extend this to take options, and to take a range; see -rangeOfString:options:range:]
 
 This method has been removed, as NSString has -containsString: on 10.10 and later.
 */

/*
 - (BOOL)utilities_containsString:(NSString *)subString;
 {
 NSRange range = [self rangeOfString:subString];
 
 return range.location != NSNotFound;
 }
 */

/**
 Returns YES if the subString is within the receiver, otherwise NO.  The case of both strings is ignored.
 
 @author DJS 2004-12.
 @version DJS 2015-01: This method has been removed, as NSString has -localizedCaseInsensitiveContainsString: on 10.10 and later..
 */

/*
 - (BOOL)utilities_containsStringCaseInsensitive:(NSString *)subString;
 {
 NSRange range = [self rangeOfString:subString options:NSCaseInsensitiveSearch];
 
 return range.location != NSNotFound;
 }
 */

- (NSComparisonResult)utilities_caseAndSpaceInsensitiveCompare:(NSString *)otherString
{
    NSString *selfString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *other = [otherString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return [selfString caseInsensitiveCompare:other];
}

/**
 Returns the receiver with all letter characters converted to lowercase, and all other characters removed.  Useful to compare two strings without extraneous punctuation etc.
 
 @author DJS 2005-02.
 @version DJS 2005-04: changed to use -stringByRemovingCharactersInSet:; was incorrectly only trimming.
 */

- (NSString *)utilities_lowercasedLettersOnly
{
    NSCharacterSet *charSet = [[NSCharacterSet lowercaseLetterCharacterSet] invertedSet];
    NSString *clean = [[self lowercaseString] utilities_stringByRemovingCharactersInSet:charSet];
    
    return clean;
}

/**
 Returns the receiver with all letter characters converted to lowercase, and all other characters other than digits removed.  Useful to compare two strings without extraneous punctuation etc.
 
 @author DJS 2007-10.
 */

- (NSString *)utilities_lowercasedLettersOrDigitsOnly;
{
    NSCharacterSet *charSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *clean = [[self lowercaseString] utilities_stringByRemovingCharactersInSet:charSet];
    
    return clean;
}

/**
 Returns YES if the receiver contains the other string, when only looking at the letter characters, and ignoring case.
 
 @author DJS 2005-02.
 */

- (BOOL)utilities_containsStringLetters:(NSString *)otherString
{
    return ([[self utilities_lowercasedLettersOnly] containsString:[otherString utilities_lowercasedLettersOnly]]);
}

/**
 Returns YES if the receiver and the other string are equal when only looking at the letter characters, and ignoring case.
 
 @author DJS 2005-02.
 */

- (BOOL)utilities_isLetterEquivalentToString:(NSString *)otherString
{
    return ([[self utilities_lowercasedLettersOnly] isEqualToString:[otherString utilities_lowercasedLettersOnly]]);
}

/**
 Returns a string with all characters matching the set removed from the receiver.
 
 @author DJS 2005-04.
 */

- (NSString *)utilities_stringByRemovingCharactersInSet:(NSCharacterSet *)set;
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];
    
    [mutString utilities_deleteCharactersInSet:set];
    
    return [NSString stringWithString:mutString];
}

/**
 Returns a string with diacritical marks removed from the receiver.  For example, "expose" with an acute accent will be returned without the accent.
 
 @author DJS 2007-04.
 */

- (NSString *)utilities_stringByRemovingDiacriticalMarks;
{
    NSMutableString *mutie = [[self decomposedStringWithCanonicalMapping] mutableCopy];
    NSCharacterSet *nonBaseSet = [NSCharacterSet nonBaseCharacterSet];
    NSRange range = NSMakeRange([mutie length], 0);
    
    while (range.location > 0)
    {
        range = [mutie rangeOfCharacterFromSet:nonBaseSet options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
        
        if (range.length == 0)
            break;
        
        [mutie deleteCharactersInRange:range];
    }
    
    return mutie;
}

- (NSString *)utilities_stringByRemovingQuotesAndSpaces
{
    BOOL insideQuote = NO;
    NSString *nextChar;
    NSMutableString *retString = [NSMutableString string];
    NSUInteger i;
    
    for (i = 0; i < [self length]; i++)
    {
        unichar nChar = [self characterAtIndex:i];
        nextChar = [NSString stringWithCharacters:&nChar length:1];
        
        if ([nextChar isEqual:@"\""])
        {
            if (!insideQuote)
                insideQuote = YES;
            else
                insideQuote = NO;
            
            continue;
        }
        
        if ([nextChar isEqual:@" "] && insideQuote)
            [retString appendString:@"&SP&"];
        else
            [retString appendString:nextChar];
    }
    
    return [NSString stringWithString:retString];
}

/**
 If the receiver has the specified prefix, returns a new string without that prefix, otherwise returns the receiver unchanged.
 
 @author DJS 2011-08.
 */

- (NSString *)utilities_stringByRemovingPrefix:(NSString *)prefix;
{
    if ([self hasPrefix:prefix])
        return [self substringFromIndex:prefix.length];
    else
        return self;
}

/**
 If the receiver has the specified suffix, returns a new string without that suffix, otherwise returns the receiver unchanged.
 
 @author DJS 2011-08.
 */

- (NSString *)utilities_stringByRemovingSuffix:(NSString *)suffix;
{
    if ([self hasSuffix:suffix])
        return [self substringToIndex:self.length - suffix.length];
    else
        return self;
}

- (NSString *)utilities_stringByDeletingLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];
    
    [mutString utilities_deleteLeadingSpaces:leading trailingSpaces:trailing];
    
    return [NSString stringWithString:mutString];
}

/**
 If the length of the receiver is less than minLength, it is padded with the specified padding string, on the left or right as requested.  [Note: currently the padding is assumed to be a single character, but support for multi-characters could be added in the future.]
 
 Note: might want to deprecate this method, since -[NSString stringByPaddingToLength:withString:startingAtIndex:] is available, though that doesn't support padding on the left side.
 
 @author DJS 2010-07 based on earlier code.
 */

- (NSString *)utilities_stringWithMinimumLength:(NSUInteger)minLength paddedWith:(NSString *)padding padLeft:(BOOL)padLeft;
{
    NSString *temp = self;
    
    if (!padding)
        padding = @" ";
    
    if ([temp length] < minLength)
    {
        NSUInteger shortfall = minLength - [temp length];
        NSUInteger i;
        
        for (i = 0; i < shortfall; i++)
        {
            if (padLeft)
                temp = [padding stringByAppendingString:temp];
            else
                temp = [temp stringByAppendingString:padding];
        }
    }
    
    return temp;
}

/**
 Returns an array of strings from the receiver, broken up on spaces to be no more than length characters each.  Supports multiple paragraphs, though assumes they are separated by LFs.  This limitation can be tweaked in the future if important.
 
 @author DJS 2006-10.
 */

- (NSArray *)utilities_componentsSeparatedByLength:(NSUInteger)length;
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *paragraphs = [self componentsSeparatedByString:@"\n"];
    NSString *paragraph;
    
    for (paragraph in paragraphs)
    {
        NSScanner *wordScanner = [NSScanner scannerWithString:paragraph];
        NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
        NSString *word = nil;
        NSString *separator = nil;
        NSMutableString *line = [NSMutableString stringWithCapacity:length];
        
        [wordScanner setCharactersToBeSkipped:[NSCharacterSet illegalCharacterSet]];
        
        while (![wordScanner isAtEnd])
        {
            [wordScanner scanUpToCharactersFromSet:whiteSpace intoString:&word];
            [wordScanner scanCharactersFromSet:whiteSpace intoString:&separator];
            
            if (([line length] + [word length] + [separator length]) <= length)
            {
                [line appendString:word];
                [line appendString:separator];
            }
            else
            {
                [array addObject:line];
                line = [NSMutableString stringWithString:word];
                [line appendString:separator];
            }
        }
        
        [array addObject:line];
    }
    
    return array;
}

/**
 Given an integer, returns its length as a string.
 
 @author DJS 2008-07.
 */

+ (NSUInteger)utilities_lengthOfInteger:(NSInteger)integer;
{
    return [[NSString stringWithFormat:@"%@", @(integer)] length];
}

/**
 Returns the length of the receiver as a signed value, to avoid "Comparison between signed and unsigned" warnings.
 
 @author DJS 2010-05.
 */

- (NSInteger)utilities_signedLength;
{
    return (NSInteger)[self length];
}

/**
 Returns the number of words in the receiver.
 
 @author DJS 2004-06.
 */

- (NSInteger)utilities_wordCount
{
    NSScanner *wordScanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
    NSMutableCharacterSet *tempSet = (NSMutableCharacterSet *)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [tempSet formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    NSCharacterSet *skipSet = [tempSet copy];
    NSInteger wordCount = 0;
    
    [wordScanner setCharactersToBeSkipped:skipSet];
    
    while ([wordScanner scanUpToCharactersFromSet:whiteSpace intoString:nil])
        wordCount++;
    
    return wordCount;
}

/**
 Returns the receiver with all characters other than digits removed.  Useful to compare two strings without extraneous punctuation etc.
 
 @author DJS 2008-11.
 */

- (NSString *)digitsOnly;
{
    NSCharacterSet *charSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    return [self utilities_stringByRemovingCharactersInSet:charSet];
}


/**
 Given a string containing a version number, of the form "1.2.3b4", returns a dictionary with each component separated out, using the keys "Major", "Minor", "Bug", "Kind" and "Stage", respectively.  In addition, key "Version" will contain the original version string, "General" will contain the general release portion, i.e. omitting the "b4" or whatever, and "IsGeneral" is a boolean indicating if it is a general release or not.  Keys are omitted if the corresponding component of the version string is missing.
 
 @author DJS 2004-05.
 */

- (NSDictionary *)utilities_dictionaryWithVersionComponents
{
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    NSString *general = self;
    NSString *kind = nil;
    NSString *stage = nil;
    
    if (range.location != NSNotFound)
    {
        general = [self substringToIndex:range.location];
        kind = [self substringWithRange:range];
        stage = [self substringFromIndex:range.location + range.length];
    }
    
    NSArray *array = [general componentsSeparatedByString:@"."];
    NSUInteger count = [array count];
    NSString *major = (count >= 1) ? array[0] : nil;
    NSString *minor = (count >= 2) ? array[1] : nil;
    NSString *bug = (count >= 3) ? array[2] : nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict utilities_setObject:self forKey:@"Version" removeIfNil:NO];
    [dict utilities_setObject:general forKey:@"General" removeIfNil:NO];
    dict[@"IsGeneral"] = @(!kind);
    [dict utilities_setObject:major forKey:@"Major" removeIfNil:NO];
    [dict utilities_setObject:minor forKey:@"Minor" removeIfNil:NO];
    [dict utilities_setObject:bug forKey:@"Bug" removeIfNil:NO];
    [dict utilities_setObject:kind forKey:@"Kind" removeIfNil:NO];
    [dict utilities_setObject:stage forKey:@"Stage" removeIfNil:NO];
    
    return dict;
}

/**
 Given a dictionary containing the keys "Major", "Minor", "Bug", "Kind" and "Stage" (some of which may be missing), returns the string representation, e.g. "1.2.3b4".  If the dictionary contains a precomposed "Version" key, it just returns that.
 
 @author DJS 2004-05.
 */

+ (NSString *)utilities_versionWithDictionary:(NSDictionary *)dict
{
    NSString *version = dict[@"Version"];
    
    if ([version length])
        return version;
    
    NSInteger major = [dict[@"Major"] integerValue];
    NSInteger minor = [dict[@"Minor"] integerValue];
    NSInteger bug = [dict[@"Bug"] integerValue];
    NSString *kind = dict[@"Kind"];
    NSInteger stage = [dict[@"Stage"] integerValue];
    
    return [self utilities_versionWithMajor:major minor:minor bug:bug kind:kind stage:stage];
}

/**
 Given values for the components of a version number (any of which may be 0 or nil), returns the string representation, e.g. "1.2.3b4".
 
 @author DJS 2004-05.
 */

+ (NSString *)utilities_versionWithMajor:(NSInteger)major minor:(NSInteger)minor bug:(NSInteger)bug kind:(NSString *)kind stage:(NSInteger)stage
{
    NSString *version = nil;
    
#if TARGET_OS_IPHONE
    if (bug)
        version = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)major, (long)minor, (long)bug];
    else
        version = [NSString stringWithFormat:@"%ld.%ld", (long)major, (long)minor];
    
    if ([kind length])
        version = [NSString stringWithFormat:@"%@%@%ld", version, kind, (long)stage];
#else
    if (bug)
        version = [NSString stringWithFormat:@"%ld.%ld.%ld", major, minor, bug];
    else
        version = [NSString stringWithFormat:@"%ld.%ld", major, minor];
    
    if ([kind length])
        version = [NSString stringWithFormat:@"%@%@%ld", version, kind, stage];
#endif
    
    return version;
}

/**
 Returns the specified number of characters from the beginning of the receiver, or the entire receiver if there aren't that many.  If a negative value is passed, it returns characters from the beginning of the receiver until the absolute value of the passed value before the length of the receiver, (e.g. [@"Hello!" left:-1] returns @"Hello"), or an empty string if there aren't that many.
 
 @author DJS 2004-03.
 @version DJS 2006-07: changed to support negative lengths.
 */

- (NSString *)utilities_left:(NSInteger)length
{
    if (length < 0)
    {
        if (-length < (NSInteger)[self length])
            return [self substringToIndex:[self length] + length];
        else
            return @"";
    }
    else
    {
        if (length < (NSInteger)[self length])
            return [self substringToIndex:length];
        else
            return self;
    }
}

/**
 Returns the specified number of characters from the end of the receiver, or the entire receiver if there aren't that many.  If a negative value is passed, it returns characters from the end of the receiver until the absolute value of the passed value before the start of the receiver, (e.g. [@"An example" left:-3] returns @"example"), or an empty string if there aren't that many.
 
 @author DJS 2004-03.
 @version DJS 2006-07: changed to support negative lengths.
 */

- (NSString *)utilities_right:(NSInteger)length
{
    if (length < 0)
    {
        NSInteger i = [self length] + length;
        
        if (i > 0)
            return [self substringFromIndex:[self length] - i];
        else
            return @"";
    }
    else
    {
        NSInteger i = [self length] - length;
        
        if (i > 0)
            return [self substringFromIndex:i];
        else
            return self;
    }
}

/**
 Returns a substring of the receiver, from the specified position and with the specified length.  If there aren't that many characters from that position, as many as there are are returned; if that position is out of range, an empty string is returned.
 
 @author DJS 2004-05.
 */

- (NSString *)utilities_from:(NSUInteger)position length:(NSUInteger)length
{
    if (position >= [self length])
        return @"";
    else
        return [[self substringFromIndex:position] utilities_left:length];
}

/**
 Returns a substring of the receiver, from the start position to the end position, both inclusive.  If either position is out of range, as much of that range as is available is returned.
 
 @author DJS 2004-05.
 */

- (NSString *)utilities_from:(NSUInteger)startPosition to:(NSUInteger)endPosition
{
    if (startPosition > endPosition)
        return @"";
    else
        return [self utilities_from:startPosition length:endPosition - startPosition + 1];
}

/**
 Similar to -substringFromIndex:, but takes a string to look for instead of an index.  If the string is within the receiver, the characters from the one after that string to the end are returned.  If it isn't within, the receiver is returned.
 
 @author DJS 2005-03.
 */

- (NSString *)utilities_substringFromString:(NSString *)string;
{
    NSRange range = [self rangeOfString:string];
    
    if (range.location == NSNotFound)
        return self;
    else
        return [self substringFromIndex:range.location + range.length];
}

/**
 Similar to -substringToIndex:, but takes a string to look for instead of an index.  If the string is within the receiver, the characters from the start up to but excluding the position of that string are returned.  If it isn't within, the receiver is returned.
 
 @author DJS 2005-03.
 */

- (NSString *)utilities_substringToString:(NSString *)string;
{
    NSRange range = [self rangeOfString:string];
    
    if (range.location == NSNotFound)
        return self;
    else
        return [self substringToIndex:range.location];
}

/**
 Similar to using both -substringFromString: and -substringToString: to return a string from between two others, except if either the startString or endString is not present in the receiver, the defaultString is returned instead.
 
 @author DJS 2012-09.
 @version DJS 2012-10: changed to use -rangeFromString:toString:.
 */

- (NSString *)utilities_substringFromString:(NSString *)startString toString:(NSString *)endString defaultString:(NSString *)defaultString;
{
    NSRange substringRange = [self utilities_rangeFromString:startString toString:endString];
    
    if (substringRange.location == NSNotFound)
        return defaultString;
    else
        return [self substringWithRange:substringRange];
}

/**
 Returns the range of the string enclosed by the specified start and end strings, or NSNotFound if either couldn't be found.
 
 @author DJS 2012-10.
 */

- (NSRange)utilities_rangeFromString:(NSString *)startString toString:(NSString *)endString;
{
    return [self utilities_rangeFromString:startString toString:endString inclusive:NO];
}

/**
 Returns the range of the string enclosed by the specified start and end strings, or NSNotFound if either couldn't be found.  If inclusive is YES, the range includes the start and end strings, otherwise it is just the text between them.
 
 @author DJS 2012-10.
 @version DJS 2013-01: changed to add the inclusive option.
 */

- (NSRange)utilities_rangeFromString:(NSString *)startString toString:(NSString *)endString inclusive:(BOOL)inclusive;
{
    NSRange startRange = [self rangeOfString:startString];
    
    if (startRange.location == NSNotFound)
        return startRange;
    
    NSInteger substringLocation = startRange.location + startRange.length;
    NSRange endRange = [self rangeOfString:endString options:0 range:NSMakeRange(substringLocation, self.length - substringLocation)];
    
    if (endRange.location == NSNotFound)
        return endRange;
    
    if (inclusive)
        return NSMakeRange(startRange.location, (endRange.location - startRange.location) + endRange.length);
    else
        return NSMakeRange(substringLocation, endRange.location - substringLocation);
}

/**
 Returns the receiver with the characters in the reverse order.
 
 @author DJS 2004-01.
 */

- (NSString *)utilities_reverse
{
    NSString *nextChar;
    NSMutableString *retString = [NSMutableString string];
    NSInteger i;
    
    for (i = [self length] - 1; i >= 0; i--)
    {
        unichar nChar = [self characterAtIndex:i];
        nextChar = [NSString stringWithCharacters:&nChar length:1];
        
        [retString appendString:nextChar];
    }
    
    return [NSString stringWithString:retString];
}

/**
 Returns a checksum of the receiver, which can be used to compare to other strings.  Similar to -hash, but that can (and has) changed between OS versions.
 
 @author DJS 2011-07.
 */

- (NSUInteger)utilities_checksum;
{
    NSUInteger base = [self length];
    NSUInteger result = base * base;
    
    for (NSUInteger i = 0; i < [self length]; i++)
    {
        result = (result + ([self characterAtIndex:i] * (i + 34)) + (732 * i) + (base * (i + 83))) % 999999999;
        //        NSLog(@"i: %d; char: %d; calc: %d; result: %d", i, [self characterAtIndex:i], ([self characterAtIndex:i] * (i + 34)) + (732 * i) + (base * (i + 83)), result);         // log
    }
    
    //    NSLog(@"checksum of %@ = %d", self, result);         // log
    
    return result;
}

/**
 Returns a lightly encrypted rendition of the receiver, for hiding passwords etc.  Decrypt via -unmask, below.
 
 @author DJS 2004-01.
 */

- (NSString *)utilities_mask
{
    if (![self length])
        return self;
    
    NSMutableString *retString = [NSMutableString string];
    NSString *fragment;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    NSUInteger randomValue = ([components day] * [components minute]) / ([components second] + 5);
    unichar character = 0;
    NSUInteger i;
    
    for (i = 0; i < [self length]; i++)
    {
        character = [self characterAtIndex:i] + 57 + (randomValue * (i + 3));
        fragment = [NSString stringWithFormat:@"%xO", character];
        
        [retString appendString:fragment];
    }
    
#if TARGET_OS_IPHONE
    return [NSString stringWithFormat:@"1a7q4%lud39%@", (unsigned long)randomValue, [retString utilities_reverse]];          // Version 1, in case I want to change the algorithm
#else
    return [NSString stringWithFormat:@"1a7q4%ldd39%@", randomValue, [retString utilities_reverse]];          // Version 1, in case I want to change the algorithm
#endif
}

/**
 Given a string that was masked via -mask, above, returns the decrypted rendition.  Okay to call with an unmasked string; just returns self in this case.
 
 @author DJS 2004-01.
 */

- (NSString *)utilities_unmask
{
    if (![self length])
        return self;
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSMutableString *retString = [NSMutableString string];
    NSString *fragment;
    unsigned hexInt = 0;
    unichar character = 0;
    NSInteger version = 0;
    NSInteger randomValue = 0;
    NSInteger i = 0;
    
    if (![scanner scanInteger:&version])
        return self;
    
    if (![scanner scanString:@"a7q4" intoString:nil])
        return self;
    
    if (![scanner scanInteger:&randomValue])
        return self;
    
    if (![scanner scanString:@"d39" intoString:nil])
        return self;
    
    NSInteger location = [scanner scanLocation];
    NSString *remaining = [[self substringFromIndex:location] utilities_reverse];
    
    scanner = [NSScanner scannerWithString:remaining];
    
    while (![scanner isAtEnd])
    {
        if ([scanner scanHexInt:&hexInt])
        {
            character = hexInt - (randomValue * (i + 3)) - 57;
            fragment = [NSString stringWithCharacters:&character length:1];
            
            [retString appendString:fragment];
        }
        
        [scanner scanString:@"O" intoString:nil];
        
        i++;
    }
    
    return [NSString stringWithString:retString];
}

/**
 Convert the receiver to a Base64-encoded edition.
 
 @param encoding The string encoding to use, e.g. NSUTF8StringEncoding.
 @returns The Base64-encoded edition.
 
 @author DJS 2014-07.
 */

- (NSString *)utilities_encodeAsBase64UsingEncoding:(NSStringEncoding)encoding;
{
    NSData *data = [self dataUsingEncoding:encoding];
    
    return [data base64EncodedStringWithOptions:0];
}

/**
 Convert the Base64-encoded receiver to a decoded string.
 
 @param encoding The string encoding to use, e.g. NSUTF8StringEncoding.
 @returns The decoded string.
 
 @author DJS 2014-07.
 */

- (NSString *)utilities_decodeFromBase64UsingEncoding:(NSStringEncoding)encoding;
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [[NSString alloc] initWithData:data encoding:encoding];
}

/**
 Returns the receiver encoded with the standard Rot13 algorithm: letter characters rotated halfway around the alphabet, other characters untouched.
 
 @author DJS 2005-03.
 @version DJS 2009-11: changed to rename the method, as seemed to be calling something else (private OS method?).
 */

- (NSString *)utilities_rotate13
{
    NSMutableString *string = [NSMutableString string];
    NSUInteger i;
    
    for (i = 0; i < [self length]; ++i)
    {
        unichar character = [self characterAtIndex:i];
        unichar capital = character & 32;
        
        character &= ~capital;
        character = ((character >= 'A') && (character <= 'z')) ? ((character - 'A' + 13) % 26 + 'A') : character;
        character |= capital;
        
        [string appendFormat:@"%c", character];
    }
    
    return string;
}

/**
 Returns a string that is guaranteed to be globally unique, and can be used as a unique identifier.  This variation omits the dashes.  Use [NSUUID UUID].UUIDString directly if dashes are okay.
 
 @author DJS 2013-07.
 @version DJS 2014-08: changed to use NSUUID.
 */

+ (NSString *)utilities_uuid;
{
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

/**
 Convenience method for -mappedFromValue:withDefault: to map a string value to an integer.
 
 @author DJS 2006-09.
 */

- (NSInteger)utilities_integerMappedFromString:(NSString *)value withDefault:(NSInteger)defaultValue;
{
    return [[self utilities_mappedFromValue:value withDefault:@(defaultValue)] integerValue];
}

/**
 Convenience method for -mappedFromValue:withDefault: map an integer value to a string.
 
 @author DJS 2006-09.
 */

- (NSString *)utilities_stringMappedFromInteger:(NSInteger)value withDefault:(NSString *)defaultValue;
{
    return [self utilities_mappedFromValue:@(value) withDefault:defaultValue];
}

/**
 Given a mapping of the form "foo=bar;blah=beep;x=y" in the receiver and a value (of any type), returns the corresponding value.  For example, with the above mapping and a value of "blah", "beep" is returned.  It works both ways: if "beep" is passed, "blah" is returned.  If a match can't be found an a default value is provided, the default is returned.  There may be an easier or more efficient way to do this, other than big if/else or switch clauses, but this seems to be tidier from a usage point of view: just one line of code to call.  (I considered adding a ExtensionMapperData class for this, but decided against it for now as I wanted to use it in a Simon plugin, which has class-sharing issues if I ever wanted to use it elsewhere in the app.)
 
 @author DJS 2006-09.
 */

- (NSString *)utilities_mappedFromValue:(id)value withDefault:(id)defaultValue;
{
    NSArray *array = [self componentsSeparatedByString:@";"];
    NSString *desired = [value description];
    NSString *result = nil;
    NSString *mapping = nil;
    
    // Scan through the mapping till a match is found:
    for (mapping in array)
    {
        NSArray *parts = [mapping componentsSeparatedByString:@"="];
        
        if ([desired isEqualToString:[parts firstObject]])
            result = [parts lastObject];
        else if ([desired isEqualToString:[parts lastObject]])
            result = [parts firstObject];
    }
    
    // If no result and a default was provided, return a copy of the default converted to a string (makes a copy as -[NSString description] returns self):
    if (!result && defaultValue)
        result = [[defaultValue copy] description];
    
    return result;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (ExtensionInternet)

/**
 An Objective-C wrapper around the Core Foundation function to convert a URL-safe string into a raw format.
 
 @author DJS 2003-10.
 */

- (NSString *)utilities_stringByReplacingPercentEscapes
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR(""));
}

/**
 An Objective-C wrapper around the Core Foundation function to convert a raw string into a URL-safe format.
 
 @author DJS 2003-07.
 */

- (NSString *)utilities_stringByAddingPercentEscapes
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, NULL, kCFStringEncodingUTF8);
#pragma clang diagnostic pop
}

/**
 Returns a string based on the receiver with diacritical marks removed and percent escapes added as needed, safe for passing as a URL parameter.
 
 @author DJS 2007-04.
 */

- (NSString *)utilities_stringByMakingURLSafe;
{
    return [[self utilities_stringByRemovingDiacriticalMarks] utilities_stringByAddingPercentEscapes];
}

/**
 Given a string containing HTML tags like "<p>" and "<a href=...>", strips out all such tags, including any incomplete tags at the start of the string (if it is a substring of the source).
 
 @author DJS 2006-10.
 */

- (NSString *)utilities_stringByStrippingHTML;
{
    NSMutableString *output = [NSMutableString stringWithCapacity:[self length]];
    
    // Scan through the string:
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    // NSScanner skips spaces and returns by default, which we don't want, so get it to skip illegal characters instead:
    [scanner setCharactersToBeSkipped:[NSCharacterSet illegalCharacterSet]];
    
    while (![scanner isAtEnd])
    {
        NSString *prefix = @"";
        
        // Scan up till a HTML tag and remember for later:
        [scanner scanUpToString:@"<" intoString:&prefix];
        
        // If we found a HTML tag, scan past it:
        if ([scanner scanString:@"<" intoString:nil] && [scanner scanUpToString:@">" intoString:nil])
            [scanner scanString:@">" intoString:nil];
        
        // Append the stuff before the HTML tag to the output:
        [output appendString:prefix];
    }
    
    NSRange range = [output rangeOfString:@">"];
    
    if (range.location != NSNotFound)
        [output deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
    
    return [NSString stringWithString:output];
}

/**
 Given a potential URL, cleans it up to ensure it is valid.  If the receiver is blank, it is returned intact.  It defaults the TLD to ".com" without interfering with the path, and adds the "http://" scheme if needed.  So, for example, "Extension/products" will result in "http://www.Extension.com/products".  To specify a different default scheme, use -stringByCleaningURLWithDefaultScheme: instead.
 
 @author DJS 2003-11.
 */

- (NSString *)utilities_stringByCleaningURL;
{
    return [self utilities_stringByCleaningURLWithDefaultScheme:nil];
}

/**
 Given a potential URL, cleans it up to ensure it is valid.  If the receiver is blank, it is returned intact.  It defaults the TLD to ".com" without interfering with the path, and adds the specified default scheme if needed.  If the scheme is nil, it defaults to "http://".  So, for example, "Extension/products" will result in "http://www.Extension.com/products".  To use "http://" as the default scheme, you could use -stringByCleaningURL instead.
 
 @author DJS 2003-11.
 @version DJS 2004-01: changed to return blank intact.
 @version DJS 2004-06: changed to support the file:// scheme, which would contain a blank url component.
 @version DJS 2007-07: changed to support the localhost domain.
 */

- (NSString *)utilities_stringByCleaningURLWithDefaultScheme:(NSString *)scheme;
{
    if (![self length])
        return self;
    
    NSString *url = self;
    NSString *path = @"/";
    NSRange range = [url rangeOfString:@"://"];
    
    if (range.location != NSNotFound)
    {
        scheme = [url substringToIndex:range.location + range.length];
        url = [url substringFromIndex:range.location + range.length];
    }
    
    range = [url rangeOfString:@"/"];
    
    if (range.location != NSNotFound)
    {
        path = [url substringFromIndex:range.location];
        url = [url substringToIndex:range.location];
    }
    
    if (![url containsString:@"."] && ![scheme isEqualToString:@"file://"] && ![url containsString:@"localhost"])
        url = [NSString stringWithFormat:@"www.%@.com", url];
    
    if (!scheme)
        scheme = @"http://";
    
    url = [NSString stringWithFormat:@"%@%@%@", scheme, url, path];
    
    return url;
}

/**
 Returns a URL representation of the receiver, or nil if it isn't a valid URL.
 
 @author DJS 2009-10.
 */

- (NSURL *)utilities_urlValue;
{
    NSURL *url = nil;
    
    if (self.length)
        url = [NSURL URLWithString:[self utilities_stringByCleaningURL]];
    
    return url;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (ExtensionFilePath)

/**
 Given a filename (not path), returns it with illegal filename characters removed or replaced.  If the resulting filename is blank, the specified default filename is returned instead.
 
 @author DJS 2003-11.
 @version DJS 2011-04: changed to remove leading dots.
 */

- (NSString *)utilities_stringByCleaningFilenameWithDefault:(NSString *)defaultFilename
{
    NSMutableString *mutString = [NSMutableString stringWithString:self];
    
    [mutString utilities_deleteLeadingSpaces:YES trailingSpaces:YES];
    [mutString utilities_replaceAllOccurrencesOf:@"/" with:@"-"];
    [mutString utilities_replaceAllOccurrencesOf:@":" with:@"-"];
    
    while ([mutString hasPrefix:@"."])
        [mutString deleteCharactersInRange:NSMakeRange(0, 1)];
    
    if ([mutString length])
        return [NSString stringWithString:mutString];
    else
        return defaultFilename;
}

/**
 Same as -stringByAppendingPathComponent:, but the filename is first cleaned via -stringByCleaningFilenameWithDefault:.
 
 @author DJS 2003-11.
 */

- (NSString *)utilities_stringByAppendingPathComponent:(NSString *)dirtyFilename cleanWithDefault:(NSString *)defaultFilename
{
    return [self stringByAppendingPathComponent:[dirtyFilename utilities_stringByCleaningFilenameWithDefault:defaultFilename]];
}

/**
 Returns the filename portion of a path, without any extension.
 
 @author DJS 2003-11.
 */

- (NSString *)utilities_lastPathComponentWithoutExtension
{
    return [[self lastPathComponent] stringByDeletingPathExtension];
}

/**
 Given a file or directory path, returns the same path with the tilde character inserted before the extension (if any), as is conventional for backup files.
 
 @author DJS 2004-03.
 */

- (NSString *)utilities_backupFilePath
{
    NSString *extension = [self pathExtension];
    NSString *previous = [self stringByDeletingPathExtension];
    NSString *path = [previous stringByAppendingString:@"~"];
    
    if ([extension length])
        path = [path stringByAppendingPathExtension:extension];
    
    return path;
}

/**
 Given a file or directory path, returns the same path if it is already unique (i.e. no file exists there), or returns that path with a number inserted before the extension to make it unique, if necessary.  See also -uniquePathWithPrefix:, below.
 
 @author DJS 2005-01.
 */

- (NSString *)utilities_uniquePath
{
    return [self utilities_uniquePathWithPrefix:nil];
}

/**
 Given a file or directory path, returns the same path if it is already unique (i.e. no file exists there), or returns that path with the prefix and/or a number inserted before the extension to make it unique (e.g. "filename copy.txt", "filename copy 2.txt", "filename copy 3.txt", etc), if necessary.  See also -uniquePath, above.
 
 @author DJS 2005-01.
 */

- (NSString *)utilities_uniquePathWithPrefix:(NSString *)prefix
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:self])
        return self;
    
    NSString *path = nil;
    NSString *extension = [self pathExtension];
    NSString *previous = [self stringByDeletingPathExtension];
    BOOL usePrefix = [prefix length];
    NSUInteger i = !usePrefix;
    
    do
    {
        i++;
        path = previous;
        
        if (usePrefix)
            path = [path stringByAppendingFormat:@" %@", prefix];
        
        if (i > 1)
#if TARGET_OS_IPHONE
            path = [path stringByAppendingFormat:@" %lu", (unsigned long)i];
#else
        path = [path stringByAppendingFormat:@" %ld", i];
#endif
        
        if ([extension length])
            path = [path stringByAppendingPathExtension:extension];
    }
    while ([[NSFileManager defaultManager] fileExistsAtPath:path]);
    
    return path;
}

/**
 Expands a tilde and/or symbolic link in the path, then checks that all directories in the path already exist.  If any don't, they are created.  The expanded path is returned.
 
 @author DJS 2004-03.
 */

- (NSString *)utilities_validatedDirectoryPath
{
    NSString *standardized = [self utilities_expandedPath];
    NSArray *components = [standardized pathComponents];
    NSString *component;
    NSString *path = @"";
    
    for (component in components)
    {
        path = [path stringByAppendingPathComponent:component];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:NULL];
    }
    
    return path;
}

/**
 Similar to -validatedDirectoryPath, above, except the last path component is assumed to be a filename, and so is ignored.
 
 @author DJS 2004-03.
 */

- (NSString *)utilities_validatedFilePath
{
    NSString *filename = [self lastPathComponent];
    NSString *directory = [self stringByDeletingLastPathComponent];
    
    directory = [directory utilities_validatedDirectoryPath];
    
    NSString *path = [directory stringByAppendingPathComponent:filename];
    
    return path;
}

/**
 Similar to the Cocoa -stringByStandardizingPath method, but also recognizes and expands the special application bundle indicator, "<APP>".  It can be abbreviated with -abbreviatedPath, below.
 
 @author DJS 2005-05.
 */

- (NSString *)utilities_expandedPath
{
    if ([self hasPrefix:@"<APP>"])
        return [self stringByReplacingOccurrencesOfString:@"<APP>" withString:[[NSBundle mainBundle] bundlePath]];
    else
        return [self stringByStandardizingPath];
}

/**
 Similar to the Cocoa -stringByAbbreviatingWithTildeInPath method, but also abbreviates a path within the application bundle with the indicator "<APP>".  It can be expanded with -expandedPath, above.
 
 @author DJS 2005-05.
 */

- (NSString *)utilities_abbreviatedPath
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    
    if ([self hasPrefix:bundlePath])
        return [self stringByReplacingOccurrencesOfString:bundlePath withString:@"<APP>"];
    else
        return [self stringByAbbreviatingWithTildeInPath];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSString (ExtensionPropertyList)

+ (NSString *)utilities_stringWithBoolValue:(BOOL)value;
{
    return [self utilities_stringWithIntegerValue:value];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableString (Extension)

/**
 Removes from the receiver all characters matching the set.
 
 @author DJS 2005-04.
 */

- (void)utilities_deleteCharactersInSet:(NSCharacterSet *)set;
{
    NSInteger i;
    
    for (i = [self length] - 1; i >= 0; i--)
    {
        unichar nChar = [self characterAtIndex:i];
        
        if ([set characterIsMember:nChar])
            [self deleteCharactersInRange:NSMakeRange(i, 1)];
    }
}

- (void)utilities_caseInsensitiveReplaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2;
{
    [self replaceOccurrencesOfString:string1 withString:string2 options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
}

- (void)utilities_replaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2
{
    [self replaceOccurrencesOfString:string1 withString:string2 options:0 range:NSMakeRange(0, [self length])];
}

/*      my old implementation; now replaced by Apple's (introduced in 10.2):
 - (void)replaceAllOccurrencesOf:(NSString *)string1 with:(NSString *)string2
 {
 BOOL done = NO;
 
 while (!done)
 {
 NSRange nextPosition = [self rangeOfString:string1];
 
 if (nextPosition.length > 0)
 [self replaceCharactersInRange:nextPosition withString:string2];
 else
 done = YES;
 }
 }
 */

- (void)utilities_deleteLeadingSpaces:(BOOL)leading trailingSpaces:(BOOL)trailing
{
    if (leading)
    {
        while ([self hasPrefix:@" "])
            [self deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    if (trailing)
    {
        while ([self hasSuffix:@" "])
            [self deleteCharactersInRange:NSMakeRange([self length] - 1, 1)];
    }
}

/**
 If the string is a valid non-empty string, it is appended to the receiver.  Otherwise, if the alternative is a valid non-empty string, it is appended.  If neither applies, the receiver is not changed.
 
 @author DJS 2004-03.
 */

- (void)utilities_appendString:(NSString *)string or:(NSString *)alternative;
{
    if ([string length])
        [self appendString:string];
    else if ([alternative length])
        [self appendString:alternative];
}

/**
 If the keyword is a valid non-empty string, the prefix and keyword are appended to the receiver (the prefix is only included if the receiver isn't empty, and may be nil if desired).  Otherwise, the receiver is not changed.
 
 @author DJS 2010-10.
 @version DJS 2011-01: changed to call -appendSeparator:prefix:keyword:suffix:or:.
 */

- (void)utilities_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword;
{
    [self utilities_appendSeparator:prefix prefix:nil keyword:keyword suffix:nil or:nil];
}

/**
 If the keyword is a valid non-empty string, the prefix, keyword, and suffix are appended to the receiver (the prefix and/or suffix may be nil if desired).  Otherwise, if the alternative is a valid non-empty string, it is appended.  If neither applies, the receiver is not changed.
 
 @author DJS 2004-03.
 @version DJS 2011-01: changed to call -appendSeparator:prefix:keyword:suffix:or:.
 */

- (void)utilities_appendPrefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix or:(NSString *)alternative;
{
    [self utilities_appendSeparator:nil prefix:prefix keyword:keyword suffix:suffix or:alternative];
}

/**
 If the keyword is a valid non-empty string, the separator, prefix, keyword and suffix are appended to the receiver (the separator, prefix and suffix may be nil if desired).  The separator is only included if the receiver isn't empty.  Otherwise, if the alternative is a valid non-empty string, it is appended.  If neither applies, the receiver is not changed.
 
 @author DJS 2011-01.
 */

- (void)utilities_appendSeparator:(NSString *)separator prefix:(NSString *)prefix keyword:(NSString *)keyword suffix:(NSString *)suffix  or:(NSString *)alternative;
{
    if (keyword.length)
    {
        if (self.length)
            [self utilities_appendString:separator or:nil];
        
        [self utilities_appendString:prefix or:nil];
        [self appendString:keyword];
        [self utilities_appendString:suffix or:nil];
    }
    else
        [self utilities_appendString:alternative or:nil];
}

@end


