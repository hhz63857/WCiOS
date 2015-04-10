//
//  News.m
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "News.h"

@implementation News

-(News *)initWithTitle:(NSString *)t uuid:(NSString*)u
{
    self = [super init];
    self.title = t;
    self.uuid = u;
    return self;
}

@end
