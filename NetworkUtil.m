//
//  networkUtil.m
//  LocalTest
//
//  Created by Huahan on 5/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NetworkUtil.h"
#import "SignupTask.h"
#import "SigninTask.h"
#import "AlertUtil.h"

@implementation NetworkUtil
+(void)uploadDataUrl:(NSString *)url pattern:(NSString *)pattern type:(NSString *)type patternCount:(NSInteger)patternCount nickname:(NSString *)nickname{
    DataModel * wtDM = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    DataModel * wpDM = [DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME];
    
    WCTask *wt = [[WCTask alloc] initWithUrl:url Pattern:pattern Type:type PatternCount:patternCount Nickname:nickname];
    WCWebPage *wp = [[WCWebPage alloc] initWithUrl:url hashcode:nil];
    
    [wtDM insertRecord:wt];
    [wpDM insertRecord:wp];
}

+(void)signUpDone:(NSString *)username :(NSString *)pwd
{
    [AsyncNetworkDelegate uploadDataByHTTPPost:[[SignupTask alloc] initWithUsername:username pwd:pwd]];
}

+(void)signInDone:(NSString *)username :(NSString *)pwd
{
    [AsyncNetworkDelegate uploadDataByHTTPGet:[[SigninTask alloc] initWithUsername:username pwd:pwd]];
}

@end
