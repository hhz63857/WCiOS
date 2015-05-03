//
//  DateFormatUtil.h
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatUtil : NSObject
+(NSString *)getNowTimeStamp;
+(NSString *)getTimeStamp:(NSDate *)myDate;
+(NSString *)getTimeElapsed:(NSDate *)start;
+(BOOL)withinTimeElapse:(NSDate *)start inSeconds:(NSInteger)seconds;
@end
