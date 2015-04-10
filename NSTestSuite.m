//
//  NSTestSuite.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NSTestSuite.h"
#import "NetworkService.h"

@implementation NSTestSuite

+(void) makeNetworkCall
{
    NSString *url = @"https://newsdigest-yql.media.yahoo.com/v2/digest?date=2015-04-01";
    NSURL *nsurl = [NSURL URLWithString:url];
    NSString *jsonString = [NetworkService performStoreRequestWithURL:nsurl];
    NSDictionary *dict = [NetworkService parseJSON:jsonString];
}

@end
