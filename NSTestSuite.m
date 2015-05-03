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
    NSString *url = @"http://www.mitbbs.com/bbsdoc/JobHunting.html";
    NSURL *nsurl = [NSURL URLWithString:url];
    NSString *jsonString = [NetworkService performStoreRequestWithURL:nsurl];
    
//    url = @"http://www.google.com";
//    nsurl = [NSURL URLWithString:url];
//    jsonString = [NetworkService performStoreRequestWithURL:nsurl];

//    NSDictionary *dict = [NetworkService parseJSON:jsonString];
}

@end
