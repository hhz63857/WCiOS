//
//  BackgroundJob.m
//  LocalTest
//
//  Created by Huahan on 9/7/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "BackgroundJob.h"

@implementation BackgroundJob

+(void)synchronizeWCWebPageWithWCTask {
    DataModel * wtDM = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    DataModel * wpDM = [DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME];
    
    NSArray *allWT = [wtDM readAll];
    NSArray *allWP = [wpDM readAll];
    
    NSMutableDictionary *distinctWTUrls = [[NSMutableDictionary alloc]init];

    for (WCTask * wt in allWT) {
        [distinctWTUrls setObject:@1 forKey: wt.url];
    }
    
    for (WCWebPage *wp in allWP) {
        if (wp.url != NULL && ![distinctWTUrls objectForKey:wp.url]){
            [wpDM removeByKey:wp.url];
            NSLog(@"Found inconsistent wcpage with wctask. Removed %@", wp.url);
        }
    }
}
@end
