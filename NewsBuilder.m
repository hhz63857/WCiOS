//
//  NewBuilder.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NewsBuilder.h"

@implementation NewsBuilder
+(NSDictionary *)parseFirst:(NSDictionary *)dict
{
    NSMutableDictionary*  ret = [[NSMutableDictionary alloc] init];
    
    NSDictionary* result = [dict valueForKey:@"result"];
    NSArray *items = [result valueForKey:@"items"];
    NSDictionary*  fItem = items[0];
    [ret setValue:[fItem valueForKey:@"uuid"] forKey:@"uuid"];
    [ret setValue:[fItem valueForKey:@"title"] forKey:@"title"];
    return ret;
}

+(NSArray *)parse:(NSDictionary *)dict
{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    NSDictionary* result = [dict valueForKey:@"result"];
    NSArray *items = [result valueForKey:@"items"];
    for (NSDictionary *item in items) {
        NSMutableDictionary*  d = [[NSMutableDictionary alloc] init];
        [d setValue:[item valueForKey:@"uuid"] forKey:@"uuid"];
        [d setValue:[item valueForKey:@"title"] forKey:@"title"];
        [ret addObject:d];
    }
    return ret;
}


@end
