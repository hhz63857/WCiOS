//
//  AsyncGetWCTask.m
//  LocalTest
//
//  Created by Huahan on 9/8/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AsyncGetWCTask.h"
#import "AlertUtil.h"
#import "WCTask.h"
#import "DataModel.h"
#import "Constant.h"
#import "WCWebPage.h"


@implementation AsyncGetWCTask

-(void)postCall:(id)data{
    [AlertUtil showAlertWithTitle:@"AWS updated" AndMsg:data AndCancelButtonTitle:@"OK"];
    NSData * jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error=nil;
    NSArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    DataModel * wtDM = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    DataModel * wpDM = [DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME];

    for (NSDictionary *dic in parsedData) {
        WCTask *wt = [[WCTask alloc] initWithUrl:dic[@"url"] Pattern:dic[@"pattern"] Type:dic[@"wctype"] PatternCount:[dic[@"patternCount"] intValue] Nickname:NULL];
        if (wt) {
            WCWebPage *wp = [[WCWebPage alloc] initWithUrl:dic[@"url"] hashcode:nil];
            [wtDM insertRecord:wt];
            [wpDM insertRecord:wp];
        }
    }
}

@end
