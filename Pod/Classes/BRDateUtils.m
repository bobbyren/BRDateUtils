//
//  BRDateUtils.m
//  BRUtilsDemo
//
//  Created by Bobby Ren on 4/5/15.
//  Copyright (c) 2015 Bobby Ren Tech. All rights reserved.
//

#import "BRDateUtils.h"

@implementation BRDateUtils

#pragma mark Day of week
+(NSDate *)mondayOfWeekForDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    [cal setFirstWeekday:2]; // forces monday to be the beginning of the week, so that sunday of the week is after monday of the week
    [cal setTimeZone:[NSTimeZone localTimeZone]];

    NSTimeInterval extends;
    NSDate *monday;

    [cal rangeOfUnit:NSWeekCalendarUnit startDate:&monday interval: &extends forDate:date];
    return monday;
}

+(NSDate *)sundayOfWeekForDate:(NSDate *)date {
    // returns the datetime for sunday in GMT (whatever time it is for midnight sunday morning in the local timezone)
    // any date comparisons using this date must be [NSDate date]!
    NSDate *monday = [self mondayOfWeekForDate:date];
    NSDate *sunday = [monday dateByAddingTimeInterval:6*24*3600];
    return sunday;
}

#pragma mark Month and year
static const NSArray *monthsShort;
static const NSArray *monthsFull;

+(const NSArray *)monthsShort {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monthsShort = @[@"Dec", @"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    });
    return monthsShort;
}

+(const NSArray *)monthsFull {
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        monthsFull = @[@"December", @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    });
    return monthsFull;
}

+(NSString *)monthForDate:(NSDate *)date format:(int)monthFormat {
    // monthFormat: 0 = MON, 1 = Mon, 2 = Month
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date];
    NSInteger month = components.month;

    if (monthFormat == 0)
        return self.monthsShort[month];
    else
        return self.monthsFull[month];
}

+(NSString *)yearForDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date];
    NSInteger year = components.year;

    return [NSString stringWithFormat:@"%lu", year];
}

#pragma mark Date formatters
static NSDateFormatter *yearMonthDayFormatter;
static NSDateFormatter *hourMinAMPMFormatter;

+(NSDateFormatter *)yearMonthDayFormatter {
    static dispatch_once_t b; dispatch_once(&b, ^{
        if (!yearMonthDayFormatter) {
            yearMonthDayFormatter = [[NSDateFormatter alloc] init];
            [yearMonthDayFormatter setDateFormat:@"yyyy-MM-dd"];
        }
    });
    return yearMonthDayFormatter;
}

+(NSDateFormatter *)hourMinAMPMFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!hourMinAMPMFormatter) {
            hourMinAMPMFormatter = [[NSDateFormatter alloc] init];
            [hourMinAMPMFormatter setDateFormat:@"h:mm a"];
        }
    });
    return hourMinAMPMFormatter;
}

#pragma mark Date format functions
+(NSString *)yearMonthDayForDate:(NSDate *)date {
    NSDateFormatter *formatter = [self yearMonthDayFormatter];
    return [formatter stringFromDate:date];
}

+(NSString *)simpleTimeForDate:(NSDate *)date {
    NSDateFormatter *formatter = [self hourMinAMPMFormatter];
    return [formatter stringFromDate:date];
}

#pragma mark Time of day 
+(NSDate *)beginningOfDate:(NSDate *)date GMT:(BOOL)gmt {
    // warning: DST
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate:date];
    
    if (gmt)
        [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    else
        [gregorian setTimeZone:[NSTimeZone localTimeZone]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [gregorian dateFromComponents:components];
}

+(NSDate *)beginningOfHour:(NSDate *)date GMT:(BOOL)gmt {
    // warning: DST
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    if (gmt)
        [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    else
        [gregorian setTimeZone:[NSTimeZone localTimeZone]];
    [components setMinute:0];
    [components setSecond:0];
    return [gregorian dateFromComponents:components];
}

@end
