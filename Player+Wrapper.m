//
//  Player+Wrapper.m
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "Player+Wrapper.h"

@implementation Player (Wrapper)

-(NSString*) getWrapper
{
    return [self.name stringByAppendingString:[@(self.id) stringValue]];
}

@end
