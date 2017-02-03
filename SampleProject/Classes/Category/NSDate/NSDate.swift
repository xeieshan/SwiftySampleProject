//
//  NSDate.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 04/03/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//

import Foundation



let D_SECOND = 1
let D_MINUTE = 60
let D_HOUR = 3600
let D_DAY = 86400
let D_WEEK = 604800
let D_YEAR = 31556926

//var sharedCalendar:NSCalendar = nil;

let componentFlags : NSCalendar.Unit = [.year, .month, .day,  .hour, .minute, .second, .weekday, .weekdayOrdinal];//.week,
extension NSDate{
    
    
    //(NSYearCalendarUnit, NSMonthCalendarUnit , NSDayCalendarUnit , NSWeekCalendarUnit ,  NSHourCalendarUnit , NSMinuteCalendarUnit , NSSecondCalendarUnit , NSWeekdayCalendarUnit , NSWeekdayOrdinalCalendarUnit);
    
    
    
    class func currentCalendar() -> NSCalendar
    {
        //
        //        if (sharedCalendar == nil){
        //            sharedCalendar = NSCalendar.autoupdatingCurrentCalendar();
        //        }
        return NSCalendar.autoupdatingCurrent as NSCalendar;
    }
    
    // Relative dates from the current date
    class func dateTomorrow() -> NSDate
    {
        return NSDate().dateByAddingsDays(dDays: 1);
    }
    
    class func dateYesterday() -> NSDate
    {
        return NSDate().dateBySubtractingDays(dDays: 1)
    }
    
    class func dateWithDaysFromNow(days:NSInteger) -> NSDate
    {
        return NSDate().dateByAddingsDays(dDays: days);
    }
    
    class func dateWithDaysBeforeNow(days:NSInteger) -> NSDate
    {
        return NSDate().dateBySubtractingDays(dDays: days);
    }
    
    class func dateWithHoursFromNow(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithHoursBeforeNow(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithMinutesFromNow(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithMinutesBeforeNow(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithSecondsFromNow(dSeconds:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(dSeconds);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    class func dateWithSecondsBeforeNow(dSeconds:NSInteger) -> NSDate
    {
        let aTimeInterval : TimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(dSeconds);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    
    // Comparing dates
    func isEqualToDateIgnoringTime(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: aDate as Date);
        
        return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
    }
    
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(aDate: NSDate());
    }
    
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(aDate: NSDate.dateTomorrow());
    }
    
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(aDate: NSDate.dateYesterday());
    }
    
    func isSameWeekAsDate(aDate : NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: aDate as Date);
        
        if (components1.weekOfYear != components2.weekOfYear) {
            return false;
        }
        
        // Must have a time interval under 1 week. Thanks @aclark
        return (abs(NSInteger(self.timeIntervalSince(aDate as Date))) < D_WEEK);
    }
    
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(aDate: NSDate());
    }
    
    func isNextWeek() -> Bool
    {
        let aTimeInterval = NSDate().timeIntervalSinceReferenceDate + Double(D_WEEK);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return self.isSameWeekAsDate(aDate: newDate);
    }
    
    func isLastWeek() -> Bool
    {
        let aTimeInterval = NSDate().timeIntervalSinceReferenceDate - Double(D_WEEK);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return self.isSameWeekAsDate(aDate: newDate);
    }
    
    func isSameMonthAsDate(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: aDate as Date);
        
        return ((components1.month == components2.month) &&
            (components1.year == components2.year));
    }
    
    func isThisMonth() -> Bool
    {
        return self.isSameMonthAsDate(aDate: NSDate());
    }
    
    func isNextMonth() -> Bool
    {
        return self.isSameMonthAsDate(aDate: NSDate().dateByAddingsMonths(dYMonths: 1));
    }
    
    func isLastMonth() -> Bool
    {
        return self.isSameMonthAsDate(aDate: NSDate().dateBySubtractingMonths(dYMonths: 1));
    }
    
    func isSameYearAsDate(aDate:NSDate) -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: aDate as Date);
        
        return (components1.year == components2.year);
    }
    
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(aDate: NSDate());
    }
    
    func isNextYear() -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: NSDate() as Date);
        
        return (components1.year! == (components2.year! + 1));
    }
    
    func isLastYear() -> Bool
    {
        let components1 = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        let components2 = NSDate.currentCalendar().components(componentFlags, from: NSDate() as Date);
        
        return (components1.year! == (components2.year! - 1));
    }
    
    func isEarlierThanDate(aDate:NSDate) -> Bool
    {
        return (self.compare(aDate as Date) == ComparisonResult.orderedAscending);
    }
    
    func isLaterThanDate(aDate:NSDate) -> Bool
    {
        return (self.compare(aDate as Date) == ComparisonResult.orderedDescending);
    }
    
    func isInFuture() -> Bool
    {
        return self.isLaterThanDate(aDate: NSDate());
    }
    
    func isInPast() -> Bool
    {
        return self.isEarlierThanDate(aDate: NSDate());
    }
    
    // Date roles
    func isTypicallyWorkday() -> Bool
    {
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        if (components.weekday == 1 || components.weekday == 7)
        {
            return true;
        }
        return false;
    }
    
    func isTypicallyWeekend() -> Bool
    {
        return !isTypicallyWeekend();
    }
    
    // Adjusting dates
    func dateByAddingsYears(dYears:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.year = dYears;
        
        let newDate = NSDate.currentCalendar().date(byAdding: dateComponents as DateComponents, to: self as Date, options:[]);
        
        return newDate! as NSDate;
        
    }
    
    func dateBySubtractingYears(dYears:NSInteger) -> NSDate{
        
        return self.dateByAddingsYears(dYears: dYears * -1);
    }
    
    
    func dateByAddingsMonths(dYMonths:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.month = dYMonths;
        
        let newDate = NSDate.currentCalendar().date(byAdding: dateComponents as DateComponents, to: self as Date, options:[]);
        
        return newDate! as NSDate;
        
    }
    
    func dateBySubtractingMonths(dYMonths:NSInteger) -> NSDate{
        
        return self.dateByAddingsYears(dYears: dYMonths * -1);
    }
    
    
    func dateByAddingsDays(dDays:NSInteger) -> NSDate{
        let dateComponents = NSDateComponents();
        dateComponents.day = dDays;
        
        let newDate = NSDate.currentCalendar().date(byAdding: dateComponents as DateComponents, to: self as Date, options:[]);
        
        return newDate! as NSDate;
        
    }
    
    func dateBySubtractingDays(dDays:NSInteger) -> NSDate{
        
        return self.dateByAddingsDays(dDays: dDays * -1);
    }
    
    func dateByAddingHours(dHours:NSInteger) -> NSDate
    {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_HOUR) * Double(dHours);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    func dateBySubtractingHours(dHours:NSInteger) -> NSDate
    {
        return self.dateByAddingHours(dHours: (dHours * -1));
    }
    
    func dateByAddingMinutes(dMinutes:NSInteger) -> NSDate
    {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(dMinutes);
        let newDate = NSDate(timeIntervalSinceReferenceDate: aTimeInterval);
        
        return newDate;
    }
    
    func dateBySubtractingMinutes(dMinutes:NSInteger) -> NSDate
    {
        return self.dateByAddingMinutes(dMinutes: (dMinutes * -1));
    }
    
    
    // Date extremes
    
    func dateAtStartOfDay() -> NSDate
    {
        var components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        return NSDate.currentCalendar().date(from: components)! as NSDate;
    }
    
    func dateAtEndOfDay() -> NSDate
    {
        var components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        components.hour = 23;
        components.minute = 59;
        components.second = 59;
        return NSDate.currentCalendar().date(from: components)! as NSDate;
    }
    
    // Retrieving intervals
    // TODO : - (NSInteger) minutesAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) minutesBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger) hoursAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) hoursBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger) daysAfterDate: (NSDate *) aDate;
    // TODO : - (NSInteger) daysBeforeDate: (NSDate *) aDate;
    // TODO : - (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;
    
    
    func stringWithDateStyle(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String{
        let formatter = DateFormatter();
        formatter.dateStyle = dateStyle;
        formatter.timeStyle = timeStyle;
        return formatter.string(from: self as Date);
    }
    
    func stringWithFormat(format:String) -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        return formatter.string(from: self as Date);
    }
    
    var shortString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
    }
    
    var shortDateString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
    }
    
    var shortTimeString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    
    var mediumString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
    
    var mediumDateString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    var mediumTimeString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.medium)
    }
    
    var longString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.long)
    }
    
    var longDateString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    }
    
    var longTimeString:String{
        return stringWithDateStyle(dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.long)
    }
    
    var nearestHour:NSInteger{
        let aTimeInterval = NSDate.timeIntervalSinceReferenceDate + Double(D_MINUTE) * Double(30);
        
        let newDate = NSDate(timeIntervalSinceReferenceDate:aTimeInterval);
        let components = NSDate.currentCalendar().components(NSCalendar.Unit.hour, from: newDate as Date);
        return components.hour!;
    }
    
    var hour:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.hour!;
    }
    
    var minute:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.minute!;
    }
    
    var seconds:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.second!;
    }
    
    var day:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.day!;
    }
    
    var month:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.month!;
    }
    
    var week:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.weekOfYear!;
    }
    
    var weekday:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.weekday!;
    }
    
    var nthWeekday:NSInteger{ // e.g. 2nd Tuesday of the month is 2
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.weekdayOrdinal!;
    }
    
    var year:NSInteger{
        let components = NSDate.currentCalendar().components(componentFlags, from: self as Date);
        return components.year!;
    }
    
    
}
