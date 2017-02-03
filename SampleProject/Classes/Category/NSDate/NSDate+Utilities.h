
#import <Foundation/Foundation.h>


#ifndef DateToolsLocalizedStrings
#define DateToolsLocalizedStrings(key) \
NSLocalizedStringFromTableInBundle(key, @"DateTools", [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"DateTools.bundle"]], nil)
#endif



#ifndef NSDateTimeAgoLocalizedStrings
#define NSDateTimeAgoLocalizedStrings(key) \
NSLocalizedStringFromTableInBundle(key, @"NSDateTimeAgo", [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NSDateTimeAgo.bundle"]], nil)
#endif
FOUNDATION_EXPORT const long long SECONDS_IN_YEAR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_28;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_29;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_30;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_31;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_WEEK;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_DAY;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_HOUR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MINUTE;
FOUNDATION_EXPORT const NSInteger MILLISECONDS_IN_DAY;

@interface NSDate (DateTools)

#pragma mark - Time Ago
+ (NSString*)timeAgoSinceDate:(NSDate*)date;
+ (NSString*)shortTimeAgoSinceDate:(NSDate*)date;
- (NSString*)timeAgoSinceNow;
- (NSString *)shortTimeAgoSinceNow;
- (NSString *)timeAgoSinceDate:(NSDate *)date;
- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates;
- (NSString *)timeAgoSinceDate:(NSDate *)date numericDates:(BOOL)useNumericDates numericTimes:(BOOL)useNumericTimes;
- (NSString *)shortTimeAgoSinceDate:(NSDate *)date;


#pragma mark - Date Components Without Calendar
//- (NSInteger)era;
//- (NSInteger)year;
//- (NSInteger)month;
//- (NSInteger)day;
//- (NSInteger)hour;
//- (NSInteger)minute;
//- (NSInteger)second;
//- (NSInteger)weekday;
- (NSInteger)weekdayOrdinal;
- (NSInteger)quarter;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;
- (NSInteger)yearForWeekOfYear;
- (NSInteger)daysInMonth;
- (NSInteger)dayOfYear;
-(NSInteger)daysInYear;
-(BOOL)isInLeapYear;
//- (BOOL)isToday;
//- (BOOL)isTomorrow;
//-(BOOL)isYesterday;
- (BOOL)isWeekend;
-(BOOL)isSameDay:(NSDate *)date;
+ (BOOL)isSameDay:(NSDate *)date asDate:(NSDate *)compareDate;

#pragma mark - Date Components With Calendar


- (NSInteger)eraWithCalendar:(NSCalendar *)calendar;
- (NSInteger)yearWithCalendar:(NSCalendar *)calendar;
- (NSInteger)monthWithCalendar:(NSCalendar *)calendar;
- (NSInteger)dayWithCalendar:(NSCalendar *)calendar;
- (NSInteger)hourWithCalendar:(NSCalendar *)calendar;
- (NSInteger)minuteWithCalendar:(NSCalendar *)calendar;
- (NSInteger)secondWithCalendar:(NSCalendar *)calendar;
- (NSInteger)weekdayWithCalendar:(NSCalendar *)calendar;
- (NSInteger)weekdayOrdinalWithCalendar:(NSCalendar *)calendar;
- (NSInteger)quarterWithCalendar:(NSCalendar *)calendar;
- (NSInteger)weekOfMonthWithCalendar:(NSCalendar *)calendar;
- (NSInteger)weekOfYearWithCalendar:(NSCalendar *)calendar;
- (NSInteger)yearForWeekOfYearWithCalendar:(NSCalendar *)calendar;


#pragma mark - Date Creating
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString;
+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone;


#pragma mark - Date Editing
//#pragma mark Date By Adding
//- (NSDate *)dateByAddingYears:(NSInteger)years;
//- (NSDate *)dateByAddingMonths:(NSInteger)months;
//- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
//- (NSDate *)dateByAddingDays:(NSInteger)days;
//- (NSDate *)dateByAddingHours:(NSInteger)hours;
//- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
//- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
//#pragma mark Date By Subtracting
//- (NSDate *)dateBySubtractingYears:(NSInteger)years;
//- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
//- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks;
//- (NSDate *)dateBySubtractingDays:(NSInteger)days;
//- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
//- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
//- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds;

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date;
-(NSInteger)monthsFrom:(NSDate *)date;
-(NSInteger)weeksFrom:(NSDate *)date;
-(NSInteger)daysFrom:(NSDate *)date;
-(double)hoursFrom:(NSDate *)date;
-(double)minutesFrom:(NSDate *)date;
-(double)secondsFrom:(NSDate *)date;
#pragma mark Time From With Calendar
-(NSInteger)yearsFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)monthsFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)weeksFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)daysFrom:(NSDate *)date calendar:(NSCalendar *)calendar;

#pragma mark Time Until
-(NSInteger)yearsUntil;
-(NSInteger)monthsUntil;
-(NSInteger)weeksUntil;
-(NSInteger)daysUntil;
-(double)hoursUntil;
-(double)minutesUntil;
-(double)secondsUntil;
#pragma mark Time Ago
-(NSInteger)yearsAgo;
-(NSInteger)monthsAgo;
-(NSInteger)weeksAgo;
-(NSInteger)daysAgo;
-(double)hoursAgo;
-(double)minutesAgo;
-(double)secondsAgo;
#pragma mark Earlier Than
-(NSInteger)yearsEarlierThan:(NSDate *)date;
-(NSInteger)monthsEarlierThan:(NSDate *)date;
-(NSInteger)weeksEarlierThan:(NSDate *)date;
-(NSInteger)daysEarlierThan:(NSDate *)date;
-(double)hoursEarlierThan:(NSDate *)date;
-(double)minutesEarlierThan:(NSDate *)date;
-(double)secondsEarlierThan:(NSDate *)date;
#pragma mark Later Than
-(NSInteger)yearsLaterThan:(NSDate *)date;
-(NSInteger)monthsLaterThan:(NSDate *)date;
-(NSInteger)weeksLaterThan:(NSDate *)date;
-(NSInteger)daysLaterThan:(NSDate *)date;
-(double)hoursLaterThan:(NSDate *)date;
-(double)minutesLaterThan:(NSDate *)date;
-(double)secondsLaterThan:(NSDate *)date;
#pragma mark Comparators
-(BOOL)isEarlierThan:(NSDate *)date;

-(BOOL)isLaterThan:(NSDate *)date;
-(BOOL)isEarlierThanOrEqualTo:(NSDate *)date;
-(BOOL)isLaterThanOrEqualTo:(NSDate *)date;

#pragma mark - Formatted Dates
#pragma mark Formatted With Style
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style locale:(NSLocale *)locale;
-(NSString *)formattedDateWithStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
#pragma mark Formatted With Format
-(NSString *)formattedDateWithFormat:(NSString *)format;
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
-(NSString *)formattedDateWithFormat:(NSString *)format locale:(NSLocale *)locale;
-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;

#pragma mark - Helpers
+(NSString *)defaultCalendarIdentifier;
+ (void)setDefaultCalendarIdentifier:(NSString *)identifier;

//#pragma mark -
//#pragma mark RFC1123
//#pragma mark -
//
///**
// Convert a RFC1123 'Full-Date' string
// (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1)
// into NSDate.
// */
//+(NSDate*)dateFromRFC1123:(NSString*)value_;
//
///**
// Convert NSDate into a RFC1123 'Full-Date' string
// (http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1).
// */
//-(NSString*)rfc1123String;

#pragma mark -
#pragma mark TimeAgo
#pragma mark -


- (NSString *) timeAgo;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormat:(NSDateFormatterStyle)dFormatter andTimeFormat:(NSDateFormatterStyle)tFormatter;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormatter:(NSDateFormatter *)formatter;


// this method only returns "{value} {unit} ago" strings and no "yesterday"/"last month" strings
- (NSString *)dateTimeAgo;
- (NSString *)timeAgoForInsta;

// this method gives when possible the date compared to the current calendar date: "this morning"/"yesterday"/"last week"/..
// when more precision is needed (= less than 6 hours ago) it returns the same output as dateTimeAgo
- (NSString *)dateTimeUntilNow;

#pragma mark -
#pragma mark Extension
#pragma mark -


@property (nonatomic, readonly) BOOL utilities_includesTime;
@property (nonatomic, readonly) BOOL utilities_isToday;

@property (nonatomic, readonly) NSInteger utilities_second;
@property (nonatomic, readonly) NSInteger utilities_minute;
@property (nonatomic, readonly) NSInteger utilities_hour;
@property (nonatomic, readonly) NSInteger utilities_weekday;
@property (nonatomic, readonly) NSInteger utilities_dayOfYear;
@property (nonatomic, readonly) NSInteger utilities_day;
@property (nonatomic, readonly) NSInteger utilities_month;
@property (nonatomic, readonly) NSInteger utilities_year;

+ (NSCalendar *)utilities_gregorianCalendar;

+ (NSDate *)utilities_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day localTimeZone:(BOOL)localTimeZone;
+ (NSDate *)utilities_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second localTimeZone:(BOOL)localTimeZone;

+ (NSDate *)utilities_dateWithString:(NSString *)string;
+ (NSDate *)utilities_dateWithString:(NSString *)string format:(NSString *)format;

- (NSString *)utilities_stringWithFormat:(NSString *)format;

+ (NSDateFormatter *)utilities_internetDateFormatter;

+ (NSDate *)utilities_dateWithJSONString:(NSString *)jsonDate;
+ (NSDate *)utilities_dateWithJSONString:(NSString *)jsonDate allowPlaceholder:(BOOL)allowPlaceholder;
- (NSString *)utilities_JSONStringValue;
- (NSString *)utilities_oldStyleJSONStringValue;

+ (NSTimeInterval)utilities_localTimeOffset;

+ (NSDate *)utilities_dateWithoutTime;
- (NSDate *)utilities_dateAsDateWithoutTime;

- (NSDateComponents *)utilities_components:(NSCalendarUnit)unitFlags;

- (BOOL)utilities_isBetweenDaysBefore:(NSInteger)daysBefore daysAfter:(NSInteger)daysAfter;

- (NSDate *)utilities_dateWithTime:(NSDate *)time;

- (NSDate *)utilities_dateByAligningToMinuteIncrement:(NSInteger)minuteIncrement;

- (NSDate *)utilities_dateByAddingMinutes:(NSInteger)numMinutes;
- (NSDate *)utilities_dateByAddingHours:(NSInteger)numHours;
- (NSDate *)utilities_dateByAddingDays:(NSInteger)numDays;
- (NSDate *)utilities_dateByAddingWeeks:(NSInteger)numWeeks;
- (NSDate *)utilities_dateByAddingMonths:(NSInteger)numMonths;
- (NSDate *)utilities_dateByAddingYears:(NSInteger)numYears;

- (NSInteger)utilities_differenceInMinutesTo:(NSDate *)toDate;
- (NSInteger)utilities_differenceInHoursTo:(NSDate *)toDate;
- (NSInteger)utilities_differenceInDaysTo:(NSDate *)toDate;
- (NSInteger)utilities_differenceInWeeksTo:(NSDate *)toDate;
- (NSInteger)utilities_differenceInMonthsTo:(NSDate *)toDate;
- (NSInteger)utilities_differenceInYearsTo:(NSDate *)toDate;

- (NSString *)utilities_formattedShortDateString;
- (NSString *)utilities_formattedDateString;
- (NSString *)utilities_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)utilities_formattedStringUsingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle allowRelative:(BOOL)allowRelative;

- (NSString *)utilities_relativeStringWithStyle:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;
+ (NSString *)utilities_relativeStringForTimeInterval:(NSTimeInterval)timeInterval style:(NSDateComponentsFormatterUnitsStyle)unitsStyle maximumUnits:(NSInteger)maximumUnits keepZero:(BOOL)keepZero defaultValue:(NSString *)defaultValue;

- (NSDate *)utilities_dateOfMonthStartWithOffset:(NSInteger)monthOffset;
- (NSDate *)utilities_dateOfMonthEndWithOffset:(NSInteger)monthOffset;

- (NSString *)utilities_descriptionWithShortDateTime;
- (NSString *)utilities_descriptionWithShortDate;
- (NSString *)utilities_descriptionWithTime;

+ (NSDate *)utilities_dateFromString:(NSString *)dateStr;
+ (NSDate *)utilities_dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSDate *)utilities_dateFromMSTimestamp:(long long)timestamp;
+ (long long)utilities_dateToMSTimetampWithDate:(NSDate *)date;

+ (NSTimeInterval)utilities_timeIntervalWithDate:(NSString *)dateString withFormat:(NSString *)format;

@end
