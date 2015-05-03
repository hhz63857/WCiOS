//
//  TypeTest.m
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "TypeTest.h"
#import "C1.h"
#import "TT.h"

@implementation TypeTest

-(void) typeTest
{
    NSString *s = @"strs";
    C1 *c = [[C1 alloc] init];
    TT *t = [[TT alloc] init];
    [c setP:s];
    [t setCp:s];
    [c print];
    [t print];
    
    s = nil;
    [c print];
    [t print];
    
    [c print];
    [t print];
    
    [c print];
    [t print];
}

@end
