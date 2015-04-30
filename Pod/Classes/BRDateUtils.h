//
//  BRDateUtils.h
//  BRUtilsDemo
//
//  Created by Bobby Ren on 4/5/15.
//  Copyright (c) 2015 Bobby Ren Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRDateUtils : NSObject
#pragma mark Day of week
+(NSDate *)mondayOfWeekForDate:(NSDate *)date;
+(NSDate *)sundayOfWeekForDate:(NSDate *)date;

#pragma mark Month and year
+(NSString *)monthForDate:(NSDate *)date format:(int)monthFormat;
+(NSString *)yearForDate:(NSDate *)date;

#pragma mark Date format functions
+(NSString *)yearMonthDayForDate:(NSDate *)date;
+(NSString *)simpleTimeForDate:(NSDate *)date;

#pragma mark Time of day
+(NSDate *)beginningOfDate:(NSDate *)date GMT:(BOOL)gmt;
+(NSDate *)beginningOfHour:(NSDate *)date GMT:(BOOL)gmt;

@end
