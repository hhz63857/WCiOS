//
//  RegexUtil.m
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "RegexUtil.h"

@implementation RegexUtil

+(NSMutableArray *)regexGetFromString:(NSString *)source WithPattern:(NSString *)pattern {
    //test regex
    NSRange sourceRange = NSMakeRange(0, [source length]);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* matches = [regex matchesInString:source options:0 range: sourceRange];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [source substringWithRange:[match range]];
        //        NSLog(@"match: %@", matchText);
        NSRange r = [match range];
        //        NSLog(@"group1: %@", [source substringWithRange:r]);
        [ret addObject: [source substringWithRange:r]];
    }
    return ret;
}

@end
