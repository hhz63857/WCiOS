//
//  WCWebPage.m
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCWebPage.h"
#import "DataModel.h"
#import "Constant.h"
#import "WCTask.h"
#import "BackgroundUtil.h"

@implementation WCWebPage

@dynamic url;
@dynamic hashcode;
@dynamic image;

-(instancetype)initWithUrl:(NSString *)url hashcode:(NSString *)hashcode
{
    WCWebPage *wt = [super initEntity:@"WCWebPage" key:url];
    if(wt) {
        wt.url = url;
        wt.hashcode = hashcode;
        wt.key = url;
    }
    return wt;
}

-(void)postCall:(id)data{
    NSArray *arr = [[DataModel getSharedInstance:WCTASK_ENTITY_NAME] getByField:@"url" fieldValue:self.url];
    
    for (WCTask *wct in arr) {
        [NSThread detachNewThreadSelector:@selector(searchPattern:) toTarget:wct withObject:data];
    }
}

-(id)getUId {
    return self.url;
}

-(id)getURL{
    return self.url;
}

-(void)postSave{
    
}

@end
