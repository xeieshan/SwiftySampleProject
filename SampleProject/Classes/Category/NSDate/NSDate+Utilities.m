
#import "NSDate+Utilities.h"
#import "NSDictionary+Utilities.h"
#import "NSString+Utilities.h"

const long long SECONDS_IN_YEAR = 31556900;
const NSInteger SECONDS_IN_MONTH_28 = 2419200;
const NSInteger SECONDS_IN_MONTH_29 = 2505600;
const NSInteger SECONDS_IN_MONTH_30 = 2592000;
const NSInteger SECONDS_IN_MONTH_31 = 2678400;
const NSInteger SECONDS_IN_WEEK = 604800;
const NSInteger SECONDS_IN_DAY = 86400;
const NSInteger SECONDS_IN_HOUR = 3600;
const NSInteger SECONDS_IN_MINUTE = 60;
const NSInteger MILLISECONDS_IN_DAY = 86400000;

typedef NS_ENUM(NSUInteger, DTDateComponent){
    DTDateComponentEra,
    DTDateComponentYear,
    DTDateComponentMonth,
    DTDateComponentDay,
    DTDateComponentHour,
    DTDateComponentMinute,
    DTDateComponentSecond,
    DTDateComponentWeekday,
    DTDateComponentWeekdayOrdinal,
    DTDateComponentQuarter,
    DTDateComponentWeekOfMonth,
    DTDateComponentWeekOfYear,
    DTDateComponentYearForWeekOfYear,
    DTDateComponentDayOfYear
};

typedef NS_ENUM(NSUInteger, DateAgoFormat){
    DateAgoLong,
    DateAgoLongUsingNumericDatesAndTimes,
    DateAgoLongUsingNumericDates,
    DateAgoLongUsingNumericTimes,
    DateAgoShort
};

typedef NS_ENUM(NSUInteger, DateAgoValues){
    YearsAgo,
    MonthsAgo,
    WeeksAgo,
    DaysAgo,
    HoursAgo,
    MinutesAgo,
    SecondsAgo
};

static const unsigned int allCalendarUnitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear;

static NSString *defaultCalendarIdentifier = nil;
static NSCalendar *implicitCalendar = nil;

@interface NSDate()
-(NSString *)getLocaleFormatUnderscoresWithValue:(double)value;
@end

@implementation NSDate (DateTools)


+ (void)load {
    [self setDefaultCalendarIdentifier:NSCalendarIdentifierGregorian];
}

#pragma mark - Time Ago


/**
 *  Takes in a date and returns a string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @param NSDate - Date to be measured from now
 *
 *  @return NSString - Formatted return string
 */
+ (NSString*)timeAgoSinceDate:(NSDate*)date{
    return [date timeAgoSinceDate:[NSDate date]];
}

/**
 *  Takes in a date and returns a shortened string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @param NSDate - Date to be measured from now
 *
 *  @return NSString - Formatted return string
 */
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date{
    return [date shortTimeAgoSinceDate:[NSDate date]];
}

/**
 *  Returns a string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @return NSString - Formatted return string
 */
- (NSString*)timeAgoSinceNow{
    return [self timeAgoSinceDate:[NSDate date]];
}

/**
 *  Returns a shortened string with the most convenient unit of time representing
 *  how far in the past that date is from now.
 *
 *  @return NSString - Formatted return string
 */
- (NSString *)shortTimeAgoSinceNow{
    return [self shortTimeAgoSinceDate:[NSDate date]];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date numericDates:NO];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates{
    return [self timeAgoSinceDate:date numericDates:useNumericDates numericTimes:NO];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates numericTimes:(BOOL)useNumericTimes{
    if (useNumericDates && useNumericTimes) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDatesAndTimes];
    } else if (useNumericDates) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDates];
    } else if (useNumericTimes) {
        return [self timeAgoSinceDate:date format:DateAgoLongUsingNumericDates];
    } else {
        return [self timeAgoSinceDate:date format:DateAgoLong];
    }
}

- (NSString *)shortTimeAgoSinceDate:(NSDate *)date{
    return [self timeAgoSinceDate:date format:DateAgoShort];
}

- (NSString *)timeAgoSinceDate:(NSDate *)date format:(DateAgoFormat)format {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;

    // if timeAgo < 24h => compare DateTime else compare Date only
    NSUInteger upToHours = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour;
    NSDateComponents *difference = [calendar components:upToHours fromDate:earliest toDate:latest options:0];
    
    if (difference.hour < 24) {
        if (difference.hour >= 1) {
            return [self localizedStringFor:format valueType:HoursAgo value:difference.hour];
        } else if (difference.minute >= 1) {
            return [self localizedStringFor:format valueType:MinutesAgo value:difference.minute];
        } else {
            return [self localizedStringFor:format valueType:SecondsAgo value:difference.second];
        }
        
    } else {
        NSUInteger bigUnits = NSCalendarUnitTimeZone | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth | NSCalendarUnitYear;
        
        NSDateComponents *components = [calendar components:bigUnits fromDate:earliest];
        earliest = [calendar dateFromComponents:components];
        
        components = [calendar components:bigUnits fromDate:latest];
        latest = [calendar dateFromComponents:components];

        difference = [calendar components:bigUnits fromDate:earliest toDate:latest options:0];
        
        if (difference.year >= 1) {
            return [self localizedStringFor:format valueType:YearsAgo value:difference.year];
        } else if (difference.month >= 1) {
            return [self localizedStringFor:format valueType:MonthsAgo value:difference.month];
        } else if (difference.weekOfYear >= 1) {
            return [self localizedStringFor:format valueType:WeeksAgo value:difference.weekOfYear];
        } else {
            return [self localizedStringFor:format valueType:DaysAgo value:difference.day];
        }
    }
}

- (NSString *)localizedStringFor:(DateAgoFormat)format valueType:(DateAgoValues)valueType value:(NSInteger)value {
    BOOL isShort = format == DateAgoShort;
    BOOL isNumericDate = format == DateAgoLongUsingNumericDates || format == DateAgoLongUsingNumericDatesAndTimes;
    BOOL isNumericTime = format == DateAgoLongUsingNumericTimes || format == DateAgoLongUsingNumericDatesAndTimes;
    
    switch (valueType) {
        case YearsAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@y" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@years ago" withValue:value];
            } else if (isNumericDate) {
                return DateToolsLocalizedStrings(@"1 year ago");
            } else {
                return DateToolsLocalizedStrings(@"Last year");
            }
        case MonthsAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@M" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@months ago" withValue:value];
            } else if (isNumericDate) {
                return DateToolsLocalizedStrings(@"1 month ago");
            } else {
                return DateToolsLocalizedStrings(@"Last month");
            }
        case WeeksAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@w" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@weeks ago" withValue:value];
            } else if (isNumericDate) {
                return DateToolsLocalizedStrings(@"1 week ago");
            } else {
                return DateToolsLocalizedStrings(@"Last week");
            }
        case DaysAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@d" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@days ago" withValue:value];
            } else if (isNumericDate) {
                return DateToolsLocalizedStrings(@"1 day ago");
            } else {
                return DateToolsLocalizedStrings(@"Yesterday");
            }
        case HoursAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@h" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@hours ago" withValue:value];
            } else if (isNumericTime) {
                return DateToolsLocalizedStrings(@"1 hour ago");
            } else {
                return DateToolsLocalizedStrings(@"An hour ago");
            }
        case MinutesAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@m" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@minutes ago" withValue:value];
            } else if (isNumericTime) {
                return DateToolsLocalizedStrings(@"1 minute ago");
            } else {
                return DateToolsLocalizedStrings(@"A minute ago");
            }
        case SecondsAgo:
            if (isShort) {
                return [self logicLocalizedStringFromFormat:@"%%d%@s" withValue:value];
            } else if (value >= 2) {
                return [self logicLocalizedStringFromFormat:@"%%d %@seconds ago" withValue:value];
            } else if (isNumericTime) {
                return DateToolsLocalizedStrings(@"1 second ago");
            } else {
                return DateToolsLocalizedStrings(@"Just now");
            }
    }
    return nil;
}

- (NSString *) logicLocalizedStringFromFormat:(NSString *)format withValue:(NSInteger)value{
    NSString * localeFormat = [NSString stringWithFormat:format, [self getLocaleFormatUnderscoresWithValue:value]];
    return [NSString stringWithFormat:DateToolsLocalizedStrings(localeFormat), value];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
/*
 - Author  : Almas Adilbek
 - Method  : getLocaleFormatUnderscoresWithValue
 - Param   : value (Double value of seconds or minutes)
 - Return  : @"" or the set of underscores ("_")
 in order to define exact translation format for specific translation rules.
 (Ex: "%d _seconds ago" for "%d секунды назад", "%d __seconds ago" for "%d секунда назад",
 and default format without underscore %d seconds ago" for "%d секунд назад")
 Updated : 12/12/2012
 
 Note    : This method must be used for all languages that have specific translation rules.
 Using method argument "value" you must define all possible conditions language have for translation
 and return set of underscores ("_") as it is an ID for locale format. No underscore ("") means default locale format;
 */

- (NSString *)getLocaleFormatUnderscoresWithValue:(double)value{
    NSString *localeCode = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    
    // Russian (ru) and Ukrainian (uk)
    if([localeCode isEqualToString:@"ru"] || [localeCode isEqualToString:@"uk"]) {
        int XY = (int)floor(value) % 100;
        int Y = (int)floor(value) % 10;
        
        if(Y == 0 || Y > 4 || (XY > 10 && XY < 15)) {
            return @"";
        }
        
        if(Y > 1 && Y < 5 && (XY < 10 || XY > 20))  {
            return @"_";
        }
        
        if(Y == 1 && XY != 11) {
            return @"__";
        }
    }
    
    // Add more languages here, which are have specific translation rules...
    
    return @"";
}
#pragma clang diagnostic pop

#pragma mark - Date Components Without Calendar
///**
// *  Returns the era of the receiver. (0 for BC, 1 for AD for Gregorian)
// *
// *  @return NSInteger
// */
//- (NSInteger)era{
//    return [self componentForDate:self type:DTDateComponentEra calendar:nil];
//}

///**
// *  Returns the year of the receiver.
// *
// *  @return NSInteger
// */
//- (NSInteger)year{
//    return [self componentForDate:self type:DTDateComponentYear calendar:nil];
//}
//
///**
// *  Returns the month of the year of the receiver.
// *
// *  @return NSInteger
// */
//- (NSInteger)month{
//    return [self componentForDate:self type:DTDateComponentMonth calendar:nil];
//}
//
///**
// *  Returns the day of the month of the receiver.
// *
// *  @return NSInteger
// */
//- (NSInteger)day{
//    return [self componentForDate:self type:DTDateComponentDay calendar:nil];
//}
//
///**
// *  Returns the hour of the day of the receiver. (0-24)
// *
// *  @return NSInteger
// */
//- (NSInteger)hour{
//    return [self componentForDate:self type:DTDateComponentHour calendar:nil];
//}
//
///**
// *  Returns the minute of the receiver. (0-59)
// *
// *  @return NSInteger
// */
//- (NSInteger)minute{
//    return [self componentForDate:self type:DTDateComponentMinute calendar:nil];
//}
//
///**
// *  Returns the second of the receiver. (0-59)
// *
// *  @return NSInteger
// */
//- (NSInteger)second{
//    return [self componentForDate:self type:DTDateComponentSecond calendar:nil];
//}

/**
 *  Returns the day of the week of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekday{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:nil];
}

/**
 *  Returns the ordinal for the day of the week of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekdayOrdinal{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:nil];
}

/**
 *  Returns the quarter of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)quarter{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:nil];
}

/**
 *  Returns the week of the month of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekOfMonth{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:nil];
}

/**
 *  Returns the week of the year of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)weekOfYear{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:nil];
}

/**
 *  I honestly don't know much about this value...
 *
 *  @return NSInteger
 */
- (NSInteger)yearForWeekOfYear{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:nil];
}

/**
 *  Returns how many days are in the month of the receiver.
 *
 *  @return NSInteger
 */
- (NSInteger)daysInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:self];
    return days.length;
}

/**
 *  Returns the day of the year of the receiver. (1-365 or 1-366 for leap year)
 *
 *  @return NSInteger
 */
- (NSInteger)dayOfYear{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:nil];
}

/**
 *  Returns how many days are in the year of the receiver.
 *
 *  @return NSInteger
 */
-(NSInteger)daysInYear{
    if (self.isInLeapYear) {
        return 366;
    }
    
    return 365;
}

/**
 *  Returns whether the receiver falls in a leap year.
 *
 *  @return NSInteger
 */
-(BOOL)isInLeapYear{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *dateComponents = [calendar components:allCalendarUnitFlags fromDate:self];
    
    if (dateComponents.year%400 == 0){
        return YES;
    }
    else if (dateComponents.year%100 == 0){
        return NO;
    }
    else if (dateComponents.year%4 == 0){
        return YES;
    }
    
    return NO;
}

//- (BOOL)isToday {
//	NSCalendar *cal = [NSCalendar currentCalendar];
//	NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
//	NSDate *today = [cal dateFromComponents:components];
//	components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
//	NSDate *otherDate = [cal dateFromComponents:components];
//
//	return [today isEqualToDate:otherDate];
//}
//
//- (BOOL)isTomorrow {
//	NSCalendar *cal = [NSCalendar currentCalendar];
//	NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[[NSDate date] dateByAddingDays:1]];
//	NSDate *tomorrow = [cal dateFromComponents:components];
//	components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
//	NSDate *otherDate = [cal dateFromComponents:components];
//    
//	return [tomorrow isEqualToDate:otherDate];
//}
//
//-(BOOL)isYesterday{
//    NSCalendar *cal = [NSCalendar currentCalendar];
//	NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[[NSDate date] dateBySubtractingDays:1]];
//	NSDate *tomorrow = [cal dateFromComponents:components];
//	components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
//	NSDate *otherDate = [cal dateFromComponents:components];
//    
//	return [tomorrow isEqualToDate:otherDate];
//}

- (BOOL)isWeekend {
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSRange weekdayRange            = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components    = [calendar components:NSCalendarUnitWeekday
                                                  fromDate:self];
    NSUInteger weekdayOfSomeDate    = [components weekday];
    
    BOOL result = NO;
    
    if (weekdayOfSomeDate == weekdayRange.location || weekdayOfSomeDate == weekdayRange.length)
        result = YES;
    
    return result;
}


/**
 *  Returns whether two dates fall on the same day.
 *
 *  @param date NSDate - Date to compare with sender
 *  @return BOOL - YES if both paramter dates fall on the same day, NO otherwise
 */
-(BOOL)isSameDay:(NSDate *)date {
    return [NSDate isSameDay:self asDate:date];
}

/**
 *  Returns whether two dates fall on the same day.
 *
 *  @param date NSDate - First date to compare
 *  @param compareDate NSDate - Second date to compare
 *  @return BOOL - YES if both paramter dates fall on the same day, NO otherwise
 */
+ (BOOL)isSameDay:(NSDate *)date asDate:(NSDate *)compareDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    NSDate *dateOne = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:compareDate];
    NSDate *dateTwo = [cal dateFromComponents:components];
    
    return [dateOne isEqualToDate:dateTwo];
}

#pragma mark - Date Components With Calendar
/**
 *  Returns the era of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the era (0 for BC, 1 for AD for Gregorian)
 */
- (NSInteger)eraWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentEra calendar:calendar];
}

/**
 *  Returns the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the year as an integer
 */
- (NSInteger)yearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYear calendar:calendar];
}

/**
 *  Returns the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the month as an integer
 */
- (NSInteger)monthWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMonth calendar:calendar];
}

/**
 *  Returns the day of the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the day of the month as an integer
 */
- (NSInteger)dayWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDay calendar:calendar];
}

/**
 *  Returns the hour of the day of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the hour of the day as an integer
 */
- (NSInteger)hourWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentHour calendar:calendar];
}

/**
 *  Returns the minute of the hour of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the minute of the hour as an integer
 */
- (NSInteger)minuteWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentMinute calendar:calendar];
}

/**
 *  Returns the second of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the second as an integer
 */
- (NSInteger)secondWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentSecond calendar:calendar];
}

/**
 *  Returns the weekday of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the weekday as an integer
 */
- (NSInteger)weekdayWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekday calendar:calendar];
}

/**
 *  Returns the weekday ordinal of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the weekday ordinal as an integer
 */
- (NSInteger)weekdayOrdinalWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekdayOrdinal calendar:calendar];
}

/**
 *  Returns the quarter of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the quarter as an integer
 */
- (NSInteger)quarterWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentQuarter calendar:calendar];
}

/**
 *  Returns the week of the month of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the week of the month as an integer
 */
- (NSInteger)weekOfMonthWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfMonth calendar:calendar];
}

/**
 *  Returns the week of the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the week of the year as an integer
 */
- (NSInteger)weekOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentWeekOfYear calendar:calendar];
}

/**
 *  Returns the year for week of the year (???) of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the year for week of the year as an integer
 */
- (NSInteger)yearForWeekOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentYearForWeekOfYear calendar:calendar];
}


/**
 *  Returns the day of the year of the receiver from a given calendar
 *
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - represents the day of the year as an integer
 */
- (NSInteger)dayOfYearWithCalendar:(NSCalendar *)calendar{
    return [self componentForDate:self type:DTDateComponentDayOfYear calendar:calendar];
}

/**
 *  Takes in a date, calendar and desired date component and returns the desired NSInteger
 *  representation for that component
 *
 *  @param date      NSDate - The date to be be mined for a desired component
 *  @param component DTDateComponent - The desired component (i.e. year, day, week, etc)
 *  @param calendar  NSCalendar - The calendar to be used in the processing (Defaults to Gregorian)
 *
 *  @return NSInteger
 */
-(NSInteger)componentForDate:(NSDate *)date type:(DTDateComponent)component calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    unsigned int unitFlags = 0;
    
    if (component == DTDateComponentYearForWeekOfYear) {
       unitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear;
    }
    else {
        unitFlags = allCalendarUnitFlags;
    }

    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    switch (component) {
        case DTDateComponentEra:
            return [dateComponents era];
        case DTDateComponentYear:
            return [dateComponents year];
        case DTDateComponentMonth:
            return [dateComponents month];
        case DTDateComponentDay:
            return [dateComponents day];
        case DTDateComponentHour:
            return [dateComponents hour];
        case DTDateComponentMinute:
            return [dateComponents minute];
        case DTDateComponentSecond:
            return [dateComponents second];
        case DTDateComponentWeekday:
            return [dateComponents weekday];
        case DTDateComponentWeekdayOrdinal:
            return [dateComponents weekdayOrdinal];
        case DTDateComponentQuarter:
            return [dateComponents quarter];
        case DTDateComponentWeekOfMonth:
            return [dateComponents weekOfMonth];
        case DTDateComponentWeekOfYear:
            return [dateComponents weekOfYear];
        case DTDateComponentYearForWeekOfYear:
            return [dateComponents yearForWeekOfYear];
        case DTDateComponentDayOfYear:
            return [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
        default:
            break;
    }
    
    return 0;
}

#pragma mark - Date Creating
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
	
	return [self dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
	
	NSDate *nsDate = nil;
	NSDateComponents *components = [[NSDateComponents alloc] init];
	
	components.year   = year;
	components.month  = month;
	components.day    = day;
	components.hour   = hour;
	components.minute = minute;
	components.second = second;
	
	nsDate = [[[self class] implicitCalendar] dateFromComponents:components];
	
	return nsDate;
}

+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString {

	return [self dateWithString:dateString formatString:formatString timeZone:[NSTimeZone systemTimeZone]];
}

+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone {

	static NSDateFormatter *parser = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    parser = [[NSDateFormatter alloc] init];
	});

	parser.dateStyle = NSDateFormatterNoStyle;
	parser.timeStyle = NSDateFormatterNoStyle;
	parser.timeZone = timeZone;
	parser.dateFormat = formatString;

	return [parser dateFromString:dateString];
}


//#pragma mark - Date Editing
//#pragma mark Date By Adding
///**
// *  Returns a date representing the receivers date shifted later by the provided number of years.
// *
// *  @param years NSInteger - Number of years to add
// *
// *  @return NSDate - Date modified by the number of desired years
// */
//- (NSDate *)dateByAddingYears:(NSInteger)years{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:years];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of months.
// *
// *  @param years NSInteger - Number of months to add
// *
// *  @return NSDate - Date modified by the number of desired months
// */
//- (NSDate *)dateByAddingMonths:(NSInteger)months{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setMonth:months];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of weeks.
// *
// *  @param years NSInteger - Number of weeks to add
// *
// *  @return NSDate - Date modified by the number of desired weeks
// */
//- (NSDate *)dateByAddingWeeks:(NSInteger)weeks{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setWeekOfYear:weeks];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of days.
// *
// *  @param years NSInteger - Number of days to add
// *
// *  @return NSDate - Date modified by the number of desired days
// */
//- (NSDate *)dateByAddingDays:(NSInteger)days{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setDay:days];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of hours.
// *
// *  @param years NSInteger - Number of hours to add
// *
// *  @return NSDate - Date modified by the number of desired hours
// */
//- (NSDate *)dateByAddingHours:(NSInteger)hours{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setHour:hours];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of minutes.
// *
// *  @param years NSInteger - Number of minutes to add
// *
// *  @return NSDate - Date modified by the number of desired minutes
// */
//- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setMinute:minutes];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted later by the provided number of seconds.
// *
// *  @param years NSInteger - Number of seconds to add
// *
// *  @return NSDate - Date modified by the number of desired seconds
// */
//- (NSDate *)dateByAddingSeconds:(NSInteger)seconds{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setSecond:seconds];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
//#pragma mark Date By Subtracting
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of years.
// *
// *  @param years NSInteger - Number of years to subtract
// *
// *  @return NSDate - Date modified by the number of desired years
// */
//- (NSDate *)dateBySubtractingYears:(NSInteger)years{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setYear:-1*years];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of months.
// *
// *  @param years NSInteger - Number of months to subtract
// *
// *  @return NSDate - Date modified by the number of desired months
// */
//- (NSDate *)dateBySubtractingMonths:(NSInteger)months{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setMonth:-1*months];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of weeks.
// *
// *  @param years NSInteger - Number of weeks to subtract
// *
// *  @return NSDate - Date modified by the number of desired weeks
// */
//- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setWeekOfYear:-1*weeks];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of days.
// *
// *  @param years NSInteger - Number of days to subtract
// *
// *  @return NSDate - Date modified by the number of desired days
// */
//- (NSDate *)dateBySubtractingDays:(NSInteger)days{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setDay:-1*days];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of hours.
// *
// *  @param years NSInteger - Number of hours to subtract
// *
// *  @return NSDate - Date modified by the number of desired hours
// */
//- (NSDate *)dateBySubtractingHours:(NSInteger)hours{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setHour:-1*hours];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of minutes.
// *
// *  @param years NSInteger - Number of minutes to subtract
// *
// *  @return NSDate - Date modified by the number of desired minutes
// */
//- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setMinute:-1*minutes];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}
//
///**
// *  Returns a date representing the receivers date shifted earlier by the provided number of seconds.
// *
// *  @param years NSInteger - Number of seconds to subtract
// *
// *  @return NSDate - Date modified by the number of desired seconds
// */
//- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds{
//    NSCalendar *calendar = [[self class] implicitCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setSecond:-1*seconds];
//    
//    return [calendar dateByAddingComponents:components toDate:self options:0];
//}

#pragma mark - Date Comparison
#pragma mark Time From
/**
 *  Returns an NSInteger representing the amount of time in years between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *  Uses the default Gregorian calendar
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return NSInteger - The NSInteger representation of the years between receiver and provided date
 */
-(NSInteger)yearsFrom:(NSDate *)date{
    return [self yearsFrom:date calendar:nil];
}

/**
 *  Returns an NSInteger representing the amount of time in months between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *  Uses the default Gregorian calendar
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return NSInteger - The NSInteger representation of the years between receiver and provided date
 */
-(NSInteger)monthsFrom:(NSDate *)date{
    return [self monthsFrom:date calendar:nil];
}

/**
 *  Returns an NSInteger representing the amount of time in weeks between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *  Uses the default Gregorian calendar
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return NSInteger - The double representation of the weeks between receiver and provided date
 */
-(NSInteger)weeksFrom:(NSDate *)date{
    return [self weeksFrom:date calendar:nil];
}

/**
 *  Returns an NSInteger representing the amount of time in days between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *  Uses the default Gregorian calendar
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return NSInteger - The double representation of the days between receiver and provided date
 */
-(NSInteger)daysFrom:(NSDate *)date{
    return [self daysFrom:date calendar:nil];
}

/**
 *  Returns an NSInteger representing the amount of time in hours between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return double - The double representation of the hours between receiver and provided date
 */
-(double)hoursFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_HOUR;
}

/**
 *  Returns an NSInteger representing the amount of time in minutes between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return double - The double representation of the minutes between receiver and provided date
 */
-(double)minutesFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/SECONDS_IN_MINUTE;
}

/**
 *  Returns an NSInteger representing the amount of time in seconds between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date NSDate - The provided date for comparison
 *
 *  @return double - The double representation of the seconds between receiver and provided date
 */
-(double)secondsFrom:(NSDate *)date{
    return [self timeIntervalSinceDate:date];
}

#pragma mark Time From With Calendar
/**
 *  Returns an NSInteger representing the amount of time in years between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date     NSDate - The provided date for comparison
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - The double representation of the years between receiver and provided date
 */
-(NSInteger)yearsFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.year;
}

/**
 *  Returns an NSInteger representing the amount of time in months between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date     NSDate - The provided date for comparison
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - The double representation of the months between receiver and provided date
 */
-(NSInteger)monthsFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:allCalendarUnitFlags fromDate:earliest toDate:latest options:0];
    return multiplier*(components.month + 12*components.year);
}

/**
 *  Returns an NSInteger representing the amount of time in weeks between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date     NSDate - The provided date for comparison
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - The double representation of the weeks between receiver and provided date
 */
-(NSInteger)weeksFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.weekOfYear;
}

/**
 *  Returns an NSInteger representing the amount of time in days between the receiver and the provided date.
 *  If the receiver is earlier than the provided date, the returned value will be negative.
 *
 *  @param date     NSDate - The provided date for comparison
 *  @param calendar NSCalendar - The calendar to be used in the calculation
 *
 *  @return NSInteger - The double representation of the days between receiver and provided date
 */
-(NSInteger)daysFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:earliest toDate:latest options:0];
    return multiplier*components.day;
}

#pragma mark Time Until
/**
 *  Returns the number of years until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return NSInteger representiation of years
 */
-(NSInteger)yearsUntil{
    return [self yearsLaterThan:[NSDate date]];
}

/**
 *  Returns the number of months until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return NSInteger representiation of months
 */
-(NSInteger)monthsUntil{
    return [self monthsLaterThan:[NSDate date]];
}

/**
 *  Returns the number of weeks until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return NSInteger representiation of weeks
 */
-(NSInteger)weeksUntil{
    return [self weeksLaterThan:[NSDate date]];
}

/**
 *  Returns the number of days until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return NSInteger representiation of days
 */
-(NSInteger)daysUntil{
    return [self daysLaterThan:[NSDate date]];
}

/**
 *  Returns the number of hours until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return double representiation of hours
 */
-(double)hoursUntil{
    return [self hoursLaterThan:[NSDate date]];
}

/**
 *  Returns the number of minutes until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return double representiation of minutes
 */
-(double)minutesUntil{
    return [self minutesLaterThan:[NSDate date]];
}

/**
 *  Returns the number of seconds until the receiver's date. Returns 0 if the receiver is the same or earlier than now.
 *
 *  @return double representiation of seconds
 */
-(double)secondsUntil{
    return [self secondsLaterThan:[NSDate date]];
}

#pragma mark Time Ago
/**
 *  Returns the number of years the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return NSInteger representiation of years
 */
-(NSInteger)yearsAgo{
    return [self yearsEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of months the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return NSInteger representiation of months
 */
-(NSInteger)monthsAgo{
    return [self monthsEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of weeks the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return NSInteger representiation of weeks
 */
-(NSInteger)weeksAgo{
    return [self weeksEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of days the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return NSInteger representiation of days
 */
-(NSInteger)daysAgo{
    return [self daysEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of hours the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return double representiation of hours
 */
-(double)hoursAgo{
    return [self hoursEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of minutes the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return double representiation of minutes
 */
-(double)minutesAgo{
    return [self minutesEarlierThan:[NSDate date]];
}

/**
 *  Returns the number of seconds the receiver's date is earlier than now. Returns 0 if the receiver is the same or later than now.
 *
 *  @return double representiation of seconds
 */
-(double)secondsAgo{
    return [self secondsEarlierThan:[NSDate date]];
}

#pragma mark Earlier Than
/**
 *  Returns the number of years the receiver's date is earlier than the provided comparison date. 
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of years
 */
-(NSInteger)yearsEarlierThan:(NSDate *)date{
    return ABS(MIN([self yearsFrom:date], 0));
}

/**
 *  Returns the number of months the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of months
 */
-(NSInteger)monthsEarlierThan:(NSDate *)date{
    return ABS(MIN([self monthsFrom:date], 0));
}

/**
 *  Returns the number of weeks the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of weeks
 */
-(NSInteger)weeksEarlierThan:(NSDate *)date{
    return ABS(MIN([self weeksFrom:date], 0));
}

/**
 *  Returns the number of days the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of days
 */
-(NSInteger)daysEarlierThan:(NSDate *)date{
    return ABS(MIN([self daysFrom:date], 0));
}

/**
 *  Returns the number of hours the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of hours
 */
-(double)hoursEarlierThan:(NSDate *)date{
    return ABS(MIN([self hoursFrom:date], 0));
}

/**
 *  Returns the number of minutes the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of minutes
 */
-(double)minutesEarlierThan:(NSDate *)date{
    return ABS(MIN([self minutesFrom:date], 0));
}

/**
 *  Returns the number of seconds the receiver's date is earlier than the provided comparison date.
 *  Returns 0 if the receiver's date is later than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of seconds
 */
-(double)secondsEarlierThan:(NSDate *)date{
    return ABS(MIN([self secondsFrom:date], 0));
}

#pragma mark Later Than
/**
 *  Returns the number of years the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of years
 */
-(NSInteger)yearsLaterThan:(NSDate *)date{
    return MAX([self yearsFrom:date], 0);
}

/**
 *  Returns the number of months the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of months
 */
-(NSInteger)monthsLaterThan:(NSDate *)date{
    return MAX([self monthsFrom:date], 0);
}

/**
 *  Returns the number of weeks the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of weeks
 */
-(NSInteger)weeksLaterThan:(NSDate *)date{
    return MAX([self weeksFrom:date], 0);
}

/**
 *  Returns the number of days the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return NSInteger representing the number of days
 */
-(NSInteger)daysLaterThan:(NSDate *)date{
    return MAX([self daysFrom:date], 0);
}

/**
 *  Returns the number of hours the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of hours
 */
-(double)hoursLaterThan:(NSDate *)date{
    return MAX([self hoursFrom:date], 0);
}

/**
 *  Returns the number of minutes the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of minutes
 */
-(double)minutesLaterThan:(NSDate *)date{
    return MAX([self minutesFrom:date], 0);
}

/**
 *  Returns the number of seconds the receiver's date is later than the provided comparison date.
 *  Returns 0 if the receiver's date is earlier than or equal to the provided comparison date.
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return double representing the number of seconds
 */
-(double)secondsLaterThan:(NSDate *)date{
    return MAX([self secondsFrom:date], 0);
}


#pragma mark Comparators
/**
 *  Returns a YES if receiver is earlier than provided comparison date, otherwise returns NO
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return BOOL representing comparison result
 */
-(BOOL)isEarlierThan:(NSDate *)date{
    if (self.timeIntervalSince1970 < date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

/**
 *  Returns a YES if receiver is later than provided comparison date, otherwise returns NO
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return BOOL representing comparison result
 */
-(BOOL)isLaterThan:(NSDate *)date{
    if (self.timeIntervalSince1970 > date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

/**
 *  Returns a YES if receiver is earlier than or equal to the provided comparison date, otherwise returns NO
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return BOOL representing comparison result
 */
-(BOOL)isEarlierThanOrEqualTo:(NSDate *)date{
    if (self.timeIntervalSince1970 <= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

/**
 *  Returns a YES if receiver is later than or equal to provided comparison date, otherwise returns NO
 *
 *  @param date NSDate - Provided date for comparison
 *
 *  @return BOOL representing comparison result
 */
-(BOOL)isLaterThanOrEqualTo:(NSDate *)date{
    if (self.timeIntervalSince1970 >= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

#pragma mark - Formatted Dates
#pragma mark Formatted With Style
/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given style
 *
 *  @param style NSDateFormatterStyle - Desired date formatting style
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style{
    return [self formattedDateWithStyle:style timeZone:[NSTimeZone systemTimeZone] locale:[NSLocale autoupdatingCurrentLocale]];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given style and time zone
 *
 *  @param style    NSDateFormatterStyle - Desired date formatting style
 *  @param timeZone NSTimeZone - Desired time zone
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone{
    return [self formattedDateWithStyle:style timeZone:timeZone locale:[NSLocale autoupdatingCurrentLocale]];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given style and locale
 *
 *  @param style  NSDateFormatterStyle - Desired date formatting style
 *  @param locale NSLocale - Desired locale
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style locale:(NSLocale *)locale{
    return [self formattedDateWithStyle:style timeZone:[NSTimeZone systemTimeZone] locale:locale];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given style, time zone and locale
 *
 *  @param style    NSDateFormatterStyle - Desired date formatting style
 *  @param timeZone NSTimeZone - Desired time zone
 *  @param locale   NSLocale - Desired locale
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });

    [formatter setDateStyle:style];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

#pragma mark Formatted With Format
/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given date format
 *
 *  @param format NSString - String representing the desired date format
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithFormat:(NSString *)format{
    return [self formattedDateWithFormat:format timeZone:[NSTimeZone systemTimeZone] locale:[NSLocale autoupdatingCurrentLocale]];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given date format and time zone
 *
 *  @param format   NSString - String representing the desired date format
 *  @param timeZone NSTimeZone - Desired time zone
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone{
    return [self formattedDateWithFormat:format timeZone:timeZone locale:[NSLocale autoupdatingCurrentLocale]];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given date format and locale
 *
 *  @param format NSString - String representing the desired date format
 *  @param locale NSLocale - Desired locale
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale{
    return [self formattedDateWithFormat:format timeZone:[NSTimeZone systemTimeZone] locale:locale];
}

/**
 *  Convenience method that returns a formatted string representing the receiver's date formatted to a given date format, time zone and locale
 *
 *  @param format   NSString - String representing the desired date format
 *  @param timeZone NSTimeZone - Desired time zone
 *  @param locale   NSLocale - Desired locale
 *
 *  @return NSString representing the formatted date string
 */
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });

    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

#pragma mark - Helpers
/**
 *  Class method that returns whether the given year is a leap year for the Gregorian Calendar
 *  Returns YES if year is a leap year, otherwise returns NO
 *
 *  @param year NSInteger - Year to evaluate
 *
 *  @return BOOL evaluation of year
 */
+(BOOL)isLeapYear:(NSInteger)year{
    if (year%400){
        return YES;
    }
    else if (year%100){
        return NO;
    }
    else if (year%4){
        return YES;
    }
    
    return NO;
}

/**
 *  Retrieves the default calendar identifier used for all non-calendar-specified operations
 *
 *  @return NSString - NSCalendarIdentifier
 */
+(NSString *)defaultCalendarIdentifier {
    return defaultCalendarIdentifier;
}

/**
 *  Sets the default calendar identifier used for all non-calendar-specified operations
 *
 *  @param identifier NSString - NSCalendarIdentifier
 */
+ (void)setDefaultCalendarIdentifier:(NSString *)identifier {
    defaultCalendarIdentifier = [identifier copy];
    implicitCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:defaultCalendarIdentifier ?: NSCalendarIdentifierGregorian];
}

/**
 *  Retrieves a default NSCalendar instance, based on the value of defaultCalendarSetting
 *
 *  @return NSCalendar The current implicit calendar
 */
+ (NSCalendar *)implicitCalendar {
    return implicitCalendar;
}
#pragma mark -
#pragma mark RFC 1123
#pragma mark -


//+(NSDate*)dateFromRFC1123:(NSString*)value_
//{
//    if(value_ == nil)
//        return nil;
//    
//    const char *str = [value_ UTF8String];
//    const char *fmt;
//    NSDate *retDate;
//    char *ret;
//    
//    fmt = "%a, %d %b %Y %H:%M:%S %Z";
//    struct tm rfc1123timeinfo;
//    memset(&rfc1123timeinfo, 0, sizeof(rfc1123timeinfo));
//    ret = strptime_l(str, fmt, &rfc1123timeinfo, NULL);
//    if (ret) {
//        time_t rfc1123time = mktime(&rfc1123timeinfo);
//        retDate = [NSDate dateWithTimeIntervalSince1970:rfc1123time];
//        if (retDate != nil)
//            return retDate;
//    }
//    
//    
//    fmt = "%A, %d-%b-%y %H:%M:%S %Z";
//    struct tm rfc850timeinfo;
//    memset(&rfc850timeinfo, 0, sizeof(rfc850timeinfo));
//    ret = strptime_l(str, fmt, &rfc850timeinfo, NULL);
//    if (ret) {
//        time_t rfc850time = mktime(&rfc850timeinfo);
//        retDate = [NSDate dateWithTimeIntervalSince1970:rfc850time];
//        if (retDate != nil)
//            return retDate;
//    }
//    
//    fmt = "%a %b %e %H:%M:%S %Y";
//    struct tm asctimeinfo;
//    memset(&asctimeinfo, 0, sizeof(asctimeinfo));
//    ret = strptime_l(str, fmt, &asctimeinfo, NULL);
//    if (ret) {
//        time_t asctime = mktime(&asctimeinfo);
//        return [NSDate dateWithTimeIntervalSince1970:asctime];
//    }
//    
//    return nil;
//}

//-(NSString*)rfc1123String
//{
//    time_t date = (time_t)[self timeIntervalSince1970];
//    struct tm timeinfo;
//    gmtime_r(&date, &timeinfo);
//    char buffer[32];
//    size_t ret = strftime_l(buffer, sizeof(buffer), "%a, %d %b %Y %H:%M:%S GMT", &timeinfo, NULL);
//    if (ret) {
//        return @(buffer);
//    } else {
//        return nil;
//    }
//}

#pragma mark -
#pragma mark TimeAgo
#pragma mark -


- (NSString *)timeAgo
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    if(deltaSeconds < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    else if(deltaSeconds < 60)
    {
        return [self stringFromFormat:@"%%d %@seconds ago" withValue:deltaSeconds];
    }
    else if(deltaSeconds < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"A minute ago");
    }
    else if (deltaMinutes < 60)
    {
        return [self stringFromFormat:@"%%d %@minutes ago" withValue:deltaMinutes];
    }
    else if (deltaMinutes < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"An hour ago");
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
        return [self stringFromFormat:@"%%d %@hours ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return NSDateTimeAgoLocalizedStrings(@"Yesterday");
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24));
        return [self stringFromFormat:@"%%d %@days ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last week");
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 7));
        return [self stringFromFormat:@"%%d %@weeks ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last month");
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
        return [self stringFromFormat:@"%%d %@months ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last year");
    }
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [self stringFromFormat:@"%%d %@years ago" withValue:minutes];
}

- (NSString *)timeAgoForInsta
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    if(deltaSeconds < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    else if(deltaSeconds < 60)
    {
        return [self stringFromFormat:@"%%d%@seconds ago" withValue:deltaSeconds];
    }
    else if(deltaSeconds < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"1m"); //@"A minute ago"
    }
    else if (deltaMinutes < 60)
    {
        return [self stringFromFormat:@"%%d%@m" withValue:deltaMinutes]; //inutes ago
    }
    else if (deltaMinutes < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"1h"); //An hour ago
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
        return [self stringFromFormat:@"%%d%@h" withValue:minutes]; //ours ago
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return NSDateTimeAgoLocalizedStrings(@"Yesterday");
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24));
        return [self stringFromFormat:@"%%d%@d" withValue:minutes]; //ays ago
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last week");
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 7));
        return [self stringFromFormat:@"%%d%@w" withValue:minutes]; //eeks ago
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last month");
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
        return [self stringFromFormat:@"%%d%@m" withValue:minutes]; //onths ago
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last year");
    }
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [self stringFromFormat:@"%%d%@y" withValue:minutes]; //ears ago
}

// Similar to timeAgo, but only returns "
- (NSString *)dateTimeAgo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitYear|
                                    NSCalendarUnitMonth|
                                    NSCalendarUnitWeekday|
                                    NSCalendarUnitDay|
                                    NSCalendarUnitHour|
                                    NSCalendarUnitMinute|
                                    NSCalendarUnitSecond
                                               fromDate:self
                                                 toDate:now
                                                options:0];
    
    if (components.year >= 1)
    {
        if (components.year == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 year ago");
        }
        return [self stringFromFormat:@"%%d %@years ago" withValue:components.year];
    }
    else if (components.month >= 1)
    {
        if (components.month == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 month ago");
        }
        return [self stringFromFormat:@"%%d %@months ago" withValue:components.month];
    }
    else if ([components weekOfMonth] >= 1)
    {
        if (components.weekOfMonth == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 week ago");
        }
        return [self stringFromFormat:@"%%d %@weeks ago" withValue:components.weekOfMonth];
    }
    else if (components.day >= 1)    // up to 6 days ago
    {
        if (components.day == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 day ago");
        }
        return [self stringFromFormat:@"%%d %@days ago" withValue:components.day];
    }
    else if (components.hour >= 1)   // up to 23 hours ago
    {
        if (components.hour == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"An hour ago");
        }
        return [self stringFromFormat:@"%%d %@hours ago" withValue:components.hour];
    }
    else if (components.minute >= 1) // up to 59 minutes ago
    {
        if (components.minute == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"A minute ago");
        }
        return [self stringFromFormat:@"%%d %@minutes ago" withValue:components.minute];
    }
    else if (components.second < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    
    // between 5 and 59 seconds ago
    return [self stringFromFormat:@"%%d %@seconds ago" withValue:components.second];
}



- (NSString *)dateTimeUntilNow
{
    NSDate * now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour
                                               fromDate:self
                                                 toDate:now
                                                options:0];
    
    if (components.hour >= 6) // if more than 6 hours ago, change precision
    {
        NSInteger startDay = [calendar ordinalityOfUnit:NSCalendarUnitDay
                                                 inUnit:NSCalendarUnitEra
                                                forDate:self];
        NSInteger endDay = [calendar ordinalityOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitEra
                                              forDate:now];
        
        NSInteger diffDays = endDay - startDay;
        if (diffDays == 0) // today!
        {
            NSDateComponents * startHourComponent = [calendar components:NSCalendarUnitHour fromDate:self];
            NSDateComponents * endHourComponent = [calendar components:NSCalendarUnitHour fromDate:self];
            if (startHourComponent.hour < 12 &&
                endHourComponent.hour > 12)
            {
                return NSDateTimeAgoLocalizedStrings(@"This morning");
            }
            else if (startHourComponent.hour >= 12 &&
                     startHourComponent.hour < 18 &&
                     endHourComponent.hour >= 18)
            {
                return NSDateTimeAgoLocalizedStrings(@"This afternoon");
            }
            return NSDateTimeAgoLocalizedStrings(@"Today");
        }
        else if (diffDays == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"Yesterday");
        }
        else
        {
            NSInteger startWeek = [calendar ordinalityOfUnit:NSCalendarUnitWeekday
                                                      inUnit:NSCalendarUnitEra
                                                     forDate:self];
            NSInteger endWeek = [calendar ordinalityOfUnit:NSCalendarUnitWeekday
                                                    inUnit:NSCalendarUnitEra
                                                   forDate:now];
            NSInteger diffWeeks = endWeek - startWeek;
            if (diffWeeks == 0)
            {
                return NSDateTimeAgoLocalizedStrings(@"This week");
            }
            else if (diffWeeks == 1)
            {
                return NSDateTimeAgoLocalizedStrings(@"Last week");
            }
            else
            {
                NSInteger startMonth = [calendar ordinalityOfUnit:NSCalendarUnitMonth
                                                           inUnit:NSCalendarUnitEra
                                                          forDate:self];
                NSInteger endMonth = [calendar ordinalityOfUnit:NSCalendarUnitMonth
                                                         inUnit:NSCalendarUnitEra
                                                        forDate:now];
                NSInteger diffMonths = endMonth - startMonth;
                if (diffMonths == 0)
                {
                    return NSDateTimeAgoLocalizedStrings(@"This month");
                }
                else if (diffMonths == 1)
                {
                    return NSDateTimeAgoLocalizedStrings(@"Last month");
                }
                else
                {
                    NSInteger startYear = [calendar ordinalityOfUnit:NSCalendarUnitYear
                                                              inUnit:NSCalendarUnitEra
                                                             forDate:self];
                    NSInteger endYear = [calendar ordinalityOfUnit:NSCalendarUnitYear
                                                            inUnit:NSCalendarUnitEra
                                                           forDate:now];
                    NSInteger diffYears = endYear - startYear;
                    if (diffYears == 0)
                    {
                        return NSDateTimeAgoLocalizedStrings(@"This year");
                    }
                    else if (diffYears == 1)
                    {
                        return NSDateTimeAgoLocalizedStrings(@"Last year");
                    }
                }
            }
        }
    }
    
    // anything else uses "time ago" precision
    return [self dateTimeAgo];
}



- (NSString *) stringFromFormat:(NSString *)format withValue:(NSInteger)value
{
    NSString * localeFormat = [NSString stringWithFormat:format, [self getLocaleFormatUnderscoresWithValue:value]];
    return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(localeFormat), value];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit
{
    return [self timeAgoWithLimit:limit dateFormat:NSDateFormatterFullStyle andTimeFormat:NSDateFormatterFullStyle];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormat:(NSDateFormatterStyle)dFormatter andTimeFormat:(NSDateFormatterStyle)tFormatter
{
    if (fabs([self timeIntervalSinceDate:[NSDate date]]) <= limit)
        return [self timeAgo];
    
    return [NSDateFormatter localizedStringFromDate:self
                                          dateStyle:dFormatter
                                          timeStyle:tFormatter];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormatter:(NSDateFormatter *)formatter
{
    if (fabs([self timeIntervalSinceDate:[NSDate date]]) <= limit)
        return [self timeAgo];
    
    return [formatter stringFromDate:self];
}

// Helper functions

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

/*
 - Author  : Almas Adilbek
 - Method  : getLocaleFormatUnderscoresWithValue
 - Param   : value (Double value of seconds or minutes)
 - Return  : @"" or the set of underscores ("_")
 in order to define exact translation format for specific translation rules.
 (Ex: "%d _seconds ago" for "%d секунды назад", "%d __seconds ago" for "%d секунда назад",
 and default format without underscore %d seconds ago" for "%d секунд назад")
 Updated : 12/12/2012
 
 Note    : This method must be used for all languages that have specific translation rules.
 Using method argument "value" you must define all possible conditions language have for translation
 and return set of underscores ("_") as it is an ID for locale format. No underscore ("") means default locale format;
 */
//-(NSString *)getLocaleFormatUnderscoresWithValue:(double)value
//{
//    NSString *localeCode = [[NSLocale preferredLanguages] objectAtIndex:0];
//    
//    // Russian (ru)
//    if([localeCode isEqual:@"ru"]) {
//        int XY = (int)floor(value) % 100;
//        int Y = (int)floor(value) % 10;
//        
//        if(Y == 0 || Y > 4 || (XY > 10 && XY < 15)) return @"";
//        if(Y > 1 && Y < 5 && (XY < 10 || XY > 20))  return @"_";
//        if(Y == 1 && XY != 11)                      return @"__";
//    }
//    
//    // Add more languages here, which are have specific translation rules...
//    
//    return @"";
//}

#pragma clang diagnostic pop
#pragma mark -
#pragma mark Extension
#pragma mark -


/**
 Singleton method to return the Gregorian calendar, creating it if necessary.
 
 @author DJS 2014-05.
 */

+ (NSCalendar *)utilities_gregorianCalendar;
{
    static id utilities_gregorianCalendar = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      utilities_gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                  });
    
    return utilities_gregorianCalendar;
}

- (NSCalendar *)utilities_gregorianCalendar;
{
    return [[self class] utilities_gregorianCalendar];
}

/**
 Returns a date representation of the specified year, month and day, with the time set to midnight, using the Gregorian calendar.  If localTimeZone is YES, the current local time zone is used, otherwise GMT is used.
 
 @author DJS 2013-02.
 */

+ (NSDate *)utilities_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day localTimeZone:(BOOL)localTimeZone;
{
    return [self utilities_dateWithYear:year month:month day:day hour:0 minute:0 second:0 localTimeZone:localTimeZone];
}

/**
 Returns a date representation of the specified year, month, day, hour, minute and second, using the Gregorian calendar.  If localTimeZone is YES, the current local time zone is used, otherwise GMT is used.
 
 @author DJS 2013-02.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

+ (NSDate *)utilities_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second localTimeZone:(BOOL)localTimeZone;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (localTimeZone)
        [components setTimeZone:[NSTimeZone defaultTimeZone]];
    else
        [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    return [gregorian dateFromComponents:components];
}

/**
 Given a date as a string, returns a new date representation, or nil if the string is nil or empty.
 
 @author DJS 2009-09.
 */

+ (NSDate *)utilities_dateWithString:(NSString *)string;
{
    if (!string.length)
        return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

/**
 Given a date as a string, plus a date format string, returns a new date representation, or nil if the string is nil or empty.
 
 @author DJS 2009-09.
 @version DJS 2010-02: changed to set the locale too.
 */

+ (NSDate *)utilities_dateWithString:(NSString *)string format:(NSString *)format;
{
    if (!string.length)
        return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    
    if (format)
        [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

/**
 Returns the receiver as a string in the specified format.
 
 @author DJS 2012-05.
 */

- (NSString *)utilities_stringWithFormat:(NSString *)format;
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    
    if (format)
        [formatter setDateFormat:format];
    
    return [formatter stringFromDate:self];
}

/**
 Singleton to return a date formatter for the RFC3339 standard internet date format.
 
 @author DJS 2012-04.
 */

+ (NSDateFormatter *)utilities_internetDateFormatter;
{
    static NSDateFormatter *sRFC3339DateFormatter = nil;
    
    if (!sRFC3339DateFormatter)
    {
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        sRFC3339DateFormatter = [NSDateFormatter new];
        
        [sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
        [sRFC3339DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];  //@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    return sRFC3339DateFormatter;
}

/**
 Given a date as a string in either JSON format (e.g. "2008-05-13T17:54:02Z" or "/Date(1210701242578)/"), returns a date representation.  Does basic cleanup of a new format string.  Returns nil if the string is empty or not a string.
 
 @author DJS 2012-06.
 */

+ (NSDate *)utilities_dateWithJSONString:(NSString *)jsonDate;
{
    return [self utilities_dateWithJSONString:jsonDate allowPlaceholder:NO];
}

/**
 Given a date as a string in either JSON format (e.g. "2008-05-13T17:54:02Z" or "/Date(1210701242578)/"), returns a date representation.  Does basic cleanup of a new format string.  Returns nil if the string is empty or not a string.
 
 @author DJS 2012-01.
 @version DJS 2012-04: changed to support both old and new formats.
 @version DJS 2012-05: changed to return nil if the string is empty or not a string.
 @version DJS 2012-06: changed to optionally return nil if it's the 1899 placeholder date.
 @version DJS 2013-01: changed to avoid accidentially removing the "Z".
 @version DJS 2013-05: changed to add support for the 0001 placeholder date.
 */

+ (NSDate *)utilities_dateWithJSONString:(NSString *)jsonDate allowPlaceholder:(BOOL)allowPlaceholder;
{
    if (![jsonDate isKindOfClass:[NSString class]] || !jsonDate.length)
        return nil;
    else if (!allowPlaceholder && ([jsonDate hasPrefix:@"1899-12-30"] || [jsonDate hasPrefix:@"0001-01-01"]))
        return nil;
    else if ([jsonDate hasPrefix:@"/Date("])
    {
        NSString *string = [[jsonDate utilities_substringFromString:@"/Date("] utilities_substringToString:@")/"];
        NSTimeInterval interval = [string longLongValue] / 1000.0;
        
        return [NSDate dateWithTimeIntervalSince1970:interval];
    }
    else
    {
        BOOL isLocalTime = ![jsonDate hasSuffix:@"Z"];
        NSRange position = [jsonDate rangeOfString:@"."];
        
        if (position.location != NSNotFound)
            jsonDate = [jsonDate substringToIndex:position.location];
        
        if (![jsonDate hasSuffix:@"Z"])
            jsonDate = [jsonDate stringByAppendingString:@"Z"];
        
        NSDate *result = [[self utilities_internetDateFormatter] dateFromString:jsonDate];
        
        if (isLocalTime)
            result = [result dateByAddingTimeInterval:[self utilities_localTimeOffset]];
        
        return result;
    }
}

/**
 Returns the receiver represented as a new-style JSON-format date string.
 
 @author DJS 2012-04.
 */

- (NSString *)utilities_JSONStringValue;
{
    return [[NSDate utilities_internetDateFormatter] stringFromDate:self];
}

/**
 Returns the receiver represented as an old-style JSON-format date string.
 
 @author DJS 2012-01.
 @version DJS 2012-03: changed to use the local time zone.
 @version DJS 2012-04: changed to rename as -oldStyleJSONStringValue.
 */

- (NSString *)utilities_oldStyleJSONStringValue;
{
    NSTimeInterval timeZoneOffset = [NSDate utilities_localTimeOffset];
    NSTimeInterval base = [self timeIntervalSince1970] + timeZoneOffset;
    NSTimeInterval interval = base * 1000.0;
    NSString *string = [NSString stringWithFormat:@"/Date(%.0f)/", interval];
    
    return string;
}

/**
 Returns the interval to add to a local date to convert it to a UTC date, i.e. allowing for the current time zone and daylight saving time.
 
 @author DJS 2013-06.
 */

+ (NSTimeInterval)utilities_localTimeOffset;
{
    return -([[NSTimeZone defaultTimeZone] secondsFromGMT] - [[NSTimeZone defaultTimeZone] daylightSavingTimeOffset]);
}

/**
 Returns the current date without the time component.
 
 @author JLM 2009-07.
 */

+ (NSDate *)utilities_dateWithoutTime;
{
    return [[NSDate date] utilities_dateAsDateWithoutTime];
}

/**
 Returns the receiver without the time component (using noon as a placeholder time, so it's DST-proof).
 
 @author DJS 2009-07.
 @version DJS 2010-02: changed to set the locale too.
 @version DJS 2011-12: changed to use date components instead of a formatter, which always seemed like a hack.
 @version DJS 2014-05: changed to use noon instead of midnight, as recommended by Apple.
 */

- (NSDate *)utilities_dateAsDateWithoutTime;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    NSDate *midnight = [calendar dateFromComponents:components];
    
    components = [NSDateComponents new];
    [components setHour:12];
    
    return [calendar dateByAddingComponents:components toDate:midnight options:0];
}

/**
 Returns YES if the receiver has time components, or NO if it's just a date.  Note: this will return NO if the time is exactly midnight.
 
 @author DJS 2012-02.
 */

- (BOOL)utilities_includesTime;
{
    return ![self isEqualToDate:[self utilities_dateAsDateWithoutTime]];
}

/**
 Returns YES if the receiver is today's date.
 
 @author DJS 2011-12.
 */

- (BOOL)utilities_isToday;
{
    return ([[NSDate utilities_dateWithoutTime] isEqualToDate:[self utilities_dateAsDateWithoutTime]]);
}

/**
 Determines if a given date is within a certain number of days before to after the current date.  The time is ignored, so for example passing -1 for daysBefore will mean any time yesterday.
 
 @param date The date to be considered.
 @param daysBefore The number of days before today.
 @param daysAfter The number of days after today.
 @returns YES if the date is in the range, otherwise NO.
 
 @author DJS 2014-03.
 */

- (BOOL)utilities_isBetweenDaysBefore:(NSInteger)daysBefore daysAfter:(NSInteger)daysAfter;
{
    NSInteger diff = [[NSDate utilities_dateWithoutTime] utilities_differenceInDaysTo:[self utilities_dateAsDateWithoutTime]];
    BOOL want = NO;
    
    if (diff < 0)
        want = -diff <= daysBefore;
    else
        want = diff <= daysAfter;
    
    //    NSLog(@"date: %@ isBetweenDaysBefore: %ld daysAfter: %ld: diff: %ld; want: %@", self, (long)daysBefore, (long)daysAfter, (long)diff, want ? @"yes" : @"no");  // log
    
    return want;
}

/**
 Returns the second of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_second;
{
    return [self utilities_components:NSCalendarUnitSecond].second;
}

/**
 Returns the minute of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_minute;
{
    return [self utilities_components:NSCalendarUnitMinute].minute;
}

/**
 Returns the hour of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_hour;
{
    return [self utilities_components:NSCalendarUnitHour].hour;
}

/**
 Returns the day of the week for the receiver.  If the current calendar is Gregorian, Sunday = 1, Monday = 2, etc.
 
 @author DJS 2013-02.
 */

- (NSInteger)utilities_weekday;
{
    return [self utilities_components:NSCalendarUnitWeekday].weekday;
}

/**
 Returns the day of the year for the receiver.  Note that this is different from the day of month.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_dayOfYear;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger dayOfYear = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    
    return dayOfYear;
}

/**
 Returns the day of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_day;
{
    return [self utilities_components:NSCalendarUnitDay].day;
}

/**
 Returns the month of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_month;
{
    return [self utilities_components:NSCalendarUnitMonth].month;
}

/**
 Returns the year of the receiver.
 
 @author DJS 2014-08.
 */

- (NSInteger)utilities_year;
{
    return [self utilities_components:NSCalendarUnitYear].year;
}

/**
 Returns the requested date components for the receiver.  See also the convenience methods like -weekday, above.
 
 @param unitFlags An ORed set of date component flags, e.g. NSCalendarUnitDay.
 @returns Date components for the specified units.
 
 @author DJS 2014-08.
 */

- (NSDateComponents *)utilities_components:(NSCalendarUnit)unitFlags;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:unitFlags fromDate:self];
}

/**
 Given a time in a NSDate, returns the receiver with the time from that instead of the receiver's.  Useful if the receiver date doesn't include the time, and the time doesn't include the date.
 
 @author DJS 2012-02.
 */

- (NSDate *)utilities_dateWithTime:(NSDate *)time;
{
    NSDate *onlyDate = [self utilities_dateAsDateWithoutTime];
    NSDate *timeBase = [time utilities_dateAsDateWithoutTime];
    NSTimeInterval interval = [time timeIntervalSinceDate:timeBase];
    
    return [onlyDate dateByAddingTimeInterval:interval];
}

/**
 Returns the receiver aligned to the nearest minute increment.  For example passing 15 to a date with a time of 15:03 will align the time to 15:00, or 09:40 will align to 09:45.
 
 @param minuteIncrement The number of minutes to use to align the time, e.g. 5 or 15.
 @returns The aligned date.
 
 @author DJS 2014-04.
 */

- (NSDate *)utilities_dateByAligningToMinuteIncrement:(NSInteger)minuteIncrement;
{
    NSInteger incrementSeconds = minuteIncrement * 60;
    NSInteger referenceSeconds = [self timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceSeconds % incrementSeconds;
    NSInteger roundedToMinuteIncrement = referenceSeconds - remainingSeconds;
    
    if (remainingSeconds > incrementSeconds / 2)
    {
        roundedToMinuteIncrement = referenceSeconds + (incrementSeconds - remainingSeconds);
    }
    
    return [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)roundedToMinuteIncrement];
}

/**
 Returns the receiver with the specified number of minutes added.
 
 @author DJS 2014-04.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSDate *)utilities_dateByAddingMinutes:(NSInteger)numMinutes;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setMinute:numMinutes];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the receiver with the specified number of hours added.
 
 @author DJS 2011-10.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSDate *)utilities_dateByAddingHours:(NSInteger)numHours;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setHour:numHours];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the receiver with the specified number of days added.
 
 @author JLM 2009-07.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSDate *)utilities_dateByAddingDays:(NSInteger)numDays;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:numDays];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the receiver with the specified number of weeks added.
 
 @author DJS 2012-01.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSDate *)utilities_dateByAddingWeeks:(NSInteger)numWeeks;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setWeekOfYear:numWeeks];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the receiver with the specified number of months added.
 
 @author DJS 2014-05.
 */

- (NSDate *)utilities_dateByAddingMonths:(NSInteger)numMonths;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setMonth:numMonths];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the receiver with the specified number of years added.
 
 @author DJS 2014-05.
 */

- (NSDate *)utilities_dateByAddingYears:(NSInteger)numYears;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *comps = [NSDateComponents new];
    [comps setYear:numYears];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:self options:0];
    
    return date;
}

/**
 Returns the number of minutes between the receiver and the specified date.
 
 @author DJS 2012-11.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInMinutesTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitMinute fromDate:self toDate:toDate options:0];
    NSInteger minutes = [components minute];
    
    return minutes;
}

/**
 Returns the number of hours between the receiver and the specified date.
 
 @author DJS 2011-10.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInHoursTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitHour fromDate:self toDate:toDate options:0];
    NSInteger hours = [components hour];
    
    return hours;
}

/**
 Returns the number of days between the receiver and the specified date.
 
 @author DJS 2009-07.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInDaysTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self toDate:toDate options:0];
    NSInteger days = [components day];
    
    return days;
}

/**
 Returns the number of weeks between the receiver and the specified date.
 
 @author DJS 2013-07.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInWeeksTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekOfYear fromDate:self toDate:toDate options:0];
    NSInteger weeks = [components weekOfYear];
    
    return weeks;
}

/**
 Returns the number of months between the receiver and the specified date.
 
 @author DJS 2013-01.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInMonthsTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self toDate:toDate options:0];
    NSInteger months = [components month];
    
    return months;
}

/**
 Returns the number of years between the receiver and the specified date.
 
 @author DJS 2013-01.
 @version DJS 2014-05: changed to use the utilities_gregorianCalendar singleton.
 */

- (NSInteger)utilities_differenceInYearsTo:(NSDate *)toDate;
{
    NSCalendar *gregorian = [self utilities_gregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self toDate:toDate options:0];
    NSInteger years = [components year];
    
    return years;
}

/**
 Returns the receiver as a string in short format.
 
 @author DJS 2011-01.
 */

- (NSString *)utilities_formattedShortDateString;
{
    return [self utilities_formattedStringUsingDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

/**
 Returns the receiver as a string in long format.
 
 @author DJS 2009-07.
 */

- (NSString *)utilities_formattedDateString;
{
    return [self utilities_formattedStringUsingDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

/**
 Returns the receiver as a string with the specified date and time styles.
 
 @author DJS 2009-07.
 @version DJS 2014-08: changed to call -formattedStringUsingDateStyle:timeStyle:allowRelative:.
 */

- (NSString *)utilities_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
{
    return [self utilities_formattedStringUsingDateStyle:dateStyle timeStyle:timeStyle allowRelative:NO];
}

/**
 Returns the receiver as a string with the specified date and time styles, optionally using a relative date (e.g. "yesterday").
 
 @param dateStyle The date style to use.
 @param timeStyle The time style to use.
 @param allowRelative YES to use a relative representation (e.g. "tomorrow"), or NO to always use absolute date.
 @returns A string representation of the receiver.
 
 @author DJS 2014-08.
 */

- (NSString *)utilities_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle allowRelative:(BOOL)allowRelative;
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.doesRelativeDateFormatting = allowRelative;
    
    return [formatter stringFromDate:self];
}

/**
 Returns the receiver as a string with a relative time, e.g. "5 minutes", and optionally a suffix, e.g. "9 months ago".  If the receiver is the distant past or future, it uses the default value.
 
 @param unitsStyle The date components formatter style, e.g. NSDateComponentsFormatterUnitsStyleShort.
 @param maximumUnits The number of units to include, e.g. 1 for "5 minutes", 2 for "5 minutes, 13 seconds".
 @param keepZero If YES, the smallest unit is allowed to display zero (e.g. "3 mins, 0 secs"; if NO, it drops the zero (e.g. just "3 mins").
 @param defaultValue A string to output if the interval is in the distant past or future.
 @returns A relative string representation of the receiver.
 
 @author DJS 2014-08.
 @version DJS 2014-11: changed to use the class method.
 @version DJS 2015-01: removed the suffix parameter, since it caused localization issues.
 */

- (NSString *)utilities_relativeStringWithStyle:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
{
    NSTimeInterval timeInterval = fabs([self timeIntervalSinceNow]);
    
    return [[self class] utilities_relativeStringForTimeInterval:timeInterval style:unitsStyle maximumUnits:maximumUnits keepZero:keepZero defaultValue:defaultValue];
}

/**
 Returns the receiver as a string with a relative time, e.g. "5 minutes", and optionally a suffix, e.g. "9 months ago".  If the receiver is the distant past or future, it uses the default value.
 
 @param timeInterval The number of seconds for the relative time.
 @param unitsStyle The date components formatter style, e.g. NSDateComponentsFormatterUnitsStyleShort.
 @param maximumUnits The number of units to include, e.g. 1 for "5 minutes", 2 for "5 minutes, 13 seconds".
 @param keepZero If YES, the smallest unit is allowed to display zero (e.g. "3 mins, 0 secs"; if NO, it drops the zero (e.g. just "3 mins").
 @param defaultValue A string to output if the interval is in the distant past or future.
 @returns A relative string representation of the receiver.
 
 @author DJS 2014-08.
 @version DJS 2014-11: changed to use NSDateComponentsFormatter (requires OS X 10.10 or iOS 8 or later).
 @version DJS 2014-12: changed to use a localized string, so French can reorder the values.
 @version DJS 2015-01: removed the suffix parameter, since it caused localization issues.
 */

+ (NSString *)utilities_relativeStringForTimeInterval:(NSTimeInterval)timeInterval style:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
{
    // If more than 10 years, assume distant past or future:
    if (fabs(timeInterval) > 60 * 60 * 24 * 365 * 10)
    {
        return defaultValue;
    }
    
    NSDateComponentsFormatter *formatter = [NSDateComponentsFormatter new];
    
    formatter.unitsStyle = unitsStyle;
    formatter.maximumUnitCount = maximumUnits;
    
    if (keepZero)
    {
        formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropLeading | NSDateComponentsFormatterZeroFormattingBehaviorDropMiddle;
    }
    else
    {
        formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
    }
    
    return [formatter stringFromTimeInterval:timeInterval];
}

/**
 Returns the date of the start of the month from the receiver, offset by the specified amount.  For example -3 for three months ago, oe 6 for in six months time.
 
 @author a commenter on Jeff's post, 2009-07.
 @version DJS 2014-05: changed to make an instance method instead of class method.
 */

- (NSDate *)utilities_dateOfMonthStartWithOffset:(NSInteger)monthOffset;
{
    NSDate *beginningOfMonth = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginningOfMonth interval:NULL forDate:self];
    NSDateComponents *month = [NSDateComponents new];
    [month setMonth:monthOffset];
    NSDate *monthStartDateWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:month toDate:beginningOfMonth options:0];
    
    return monthStartDateWithOffset;
}

/**
 Returns the date of the end of the month from the receiver, offset by the specified amount.
 
 @author a commenter on Jeff's post, 2009-07.
 @version DJS 2014-05: changed to make an instance method instead of class method.
 */

- (NSDate *)utilities_dateOfMonthEndWithOffset:(NSInteger)monthOffset;
{
    NSDate *beginningOfMonth = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&beginningOfMonth interval:NULL forDate:self];
    
    // Add 1 month + offset in months to the beginning of the current month:
    NSDateComponents *oneMonth = [NSDateComponents new];
    [oneMonth setMonth:(1 + monthOffset)];
    NSDate *beginningOfNextMonthWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:oneMonth toDate:beginningOfMonth options:0];
    
    // Subtract 1 second from the beginning next month with offset to get the end of the month with offset:
    NSDateComponents *negativeOneSecond = [NSDateComponents new];
    [negativeOneSecond setSecond:-1];
    NSDate *monthEndDateWithOffset = [[NSCalendar currentCalendar] dateByAddingComponents:negativeOneSecond toDate:beginningOfNextMonthWithOffset options:0];
    
    return monthEndDateWithOffset;
}

// Note: see also -formattedStringUsingDateStyle:timeStyle:, equivalent to a -descriptionWithDateFormat:timeFormat: method.

/**
 Returns the receiver expressed as a string using the user's preferred short date and time formats.  This method is compatible both with NSDate and NSCalendarDate.
 
 @author DJS 2003-11.
 @version DJS 2007-10: changed to avoid deprecated NSShortDateFormatString etc.
 */

- (NSString *)utilities_descriptionWithShortDateTime;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:self];
}

/**
 Returns the receiver expressed as a string using the user's preferred short date format.  This method is compatible both with NSDate and NSCalendarDate.
 
 @author DJS 2003-11.
 @version DJS 2007-10: changed to avoid deprecated NSShortDateFormatString etc.
 */

- (NSString *)utilities_descriptionWithShortDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [dateFormatter stringFromDate:self];
}

/**
 Returns the receiver expressed as a string using the user's preferred short time format.  This method is compatible both with NSDate and NSCalendarDate.
 
 @author DJS 2003-11.
 @version DJS 2007-10: changed to avoid deprecated NSShortDateFormatString etc.
 */

- (NSString *)utilities_descriptionWithTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)utilities_dateFromString:(NSString *)string {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSDate *)utilities_dateFromMSTimestamp:(long long)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:(double)(timestamp*0.001)];
}

+ (long long)utilities_dateToMSTimetampWithDate:(NSDate *)date {
    return (long long)([date timeIntervalSince1970] * 1000);
}

+ (NSDate *)utilities_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSTimeInterval)utilities_timeIntervalWithDate:(NSString *)dateString withFormat:(NSString *)format {
    NSDate *date = [NSDate utilities_dateFromString:dateString withFormat:format];
    return [date timeIntervalSince1970];
}


@end
