//
//  DataModelTest.m
//  LocalTest
//
//  Created by Huahan on 4/19/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "DataModelTest.h"
#import "WCWebPage.h"
#import "WCTask.h"
#import "Constant.h"

@implementation DataModelTest
+(void)startTest{
    DataModel *dm = [DataModel getSharedInstance:@"WCWebPage"];
    
    WCWebPage *wp = [[WCWebPage alloc] initWithUrl:@"dumurl.com" hashcode:@"-1"];
    
    [dm insertRecord:wp force:NO];
    WCWebPage* w = [dm getByKey:@"dumurl.com"];
    
//    [dm updateWithKey:@"dumurl.com" changes:@{@"html":@"newHtml"}];
    WCWebPage* nw = [dm getByKey:@"dumurl.com"];
}

+(void)startNTest{
    DataModel *dm = [DataModel getSharedInstance:@"WCWebPage"];
    NSString *key = @"https://www.google.com/?gws_rd=ssl";
    WCWebPage *wcp = [[WCWebPage alloc] initWithUrl:key hashcode:@"old"];
    [dm insertRecord:wcp];
    WCWebPage *r = [dm getByKey:key];
    NSAssert([r.url isEqualToString:key], @"1");
    r = [dm getByKey:key];
    NSAssert([r.url isEqualToString:key], @"1");

    NSArray *rarr = [dm getByField:@"url" fieldValue:key];
    NSAssert([rarr count] > 0, @"");
    
    [dm updateWithKey:key changes:@{@"hashcode":@"123d"}];
    
    rarr = [dm getByField:@"url" fieldValue:key];
    r = rarr[0];
    NSAssert([r.url isEqualToString:key], @"1");
    NSAssert([r.hashcode isEqualToString:@"123d"], @"1");

    
    r = [dm getByKey:key];
    NSAssert([r.url isEqualToString:key], @"1");
    NSAssert([r.hashcode isEqualToString:@"123d"], @"1");

    [dm removeByKey:key];
    rarr = [dm getByField:@"url" fieldValue:key];
    NSAssert(rarr && [rarr count] == 0, @"Assert rarr is an empty array");
    
    r = [dm getByKey:key];
    NSAssert(r == nil, @"");
}

+(void)testSharedInstances
{
    DataModel *dm1 = [DataModel getSharedInstance:@"WCTask"];
    DataModel *dm2 = [DataModel getSharedInstance:@"WCTask"];
    DataModel *dm3 = [DataModel getSharedInstance:@"WCWebPage"];
    NSLog(@"%@, %@, %@", dm1, dm2, dm3);
}
@end
