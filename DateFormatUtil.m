//
//  DateFormatUtil.m
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "DateFormatUtil.h"

@implementation DateFormatUtil
+(NSString *)getNowTimeStamp
{
    NSDate *myDate = [[NSDate alloc] init];
    return [self getTimeStamp:myDate];
}

+(NSString *)getTimeStamp:(NSDate *)myDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMMM dd, yyyy, hh:mm aa"];
    return [dateFormat stringFromDate:myDate];
}

+(NSString *)getTimeElapsed:(NSDate *)start
{
    NSTimeInterval timeInterval = [start timeIntervalSinceNow];
    NSInteger ti = (NSInteger)timeInterval;
    NSInteger seconds = - ti % 60;
    NSInteger minutes = - (ti / 60) % 60;
    NSInteger hours = - (ti / 3600);
    NSString *target;
    if (hours > 0) {
        target = [[@(hours) stringValue] stringByAppendingString:@" hours"];
    } else if(minutes > 0) {
        target = [[@(minutes) stringValue] stringByAppendingString:@" minutes"];
    } else {
        target = [[@(seconds) stringValue] stringByAppendingString:@" seconds"];
    }
    return target;
}

+(BOOL)withinTimeElapse:(NSDate *)start inSeconds:(NSInteger)seconds
{
    NSTimeInterval timeInterval = [start timeIntervalSinceNow];
    NSInteger ti = - (NSInteger)timeInterval;
    return ti < seconds;
}
@end
