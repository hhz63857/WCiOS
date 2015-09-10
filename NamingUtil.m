//
//  NamingUtil.m
//  LocalTest
//
//  Created by Huahan on 5/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NamingUtil.h"
#import "WCTask.h"

@implementation NamingUtil
+(NSString *)getNickName:(WCTask *)wctask{
    return wctask.nickname != nil && [wctask.nickname length] > 0? wctask.nickname : [wctask.url length] > 16 ? [[wctask.url substringWithRange:NSMakeRange(11, 5)] stringByAppendingString:@"..."] : @"N/A";
}

@end
