//
//  RegexUtilTest.m
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "RegexUtilTest.h"
#import "RegexUtil.h"

@implementation RegexUtilTest

+(void) testRegex
{
    NSMutableArray *arr = [RegexUtil regexGetFromString:@"google asdfa google goo lll " WithPattern:@"google"];
}

@end
