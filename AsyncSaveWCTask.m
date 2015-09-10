//
//  AsyncSaveWCTask.m
//  LocalTest
//
//  Created by Huahan on 5/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AsyncNetworkDelegate.h"
#import "AsyncSaveWCTask.h"
#import "Constant.h"
#import "DeviceUtil.h"
#import "AlertUtil.h"

@implementation AsyncSaveWCTask

-(instancetype)initWithWCTask:(WCTask *)wt{
    self = [super init];
    self.wt = wt;
    self.url = nil;
    if (self.wt) {
        NSString *token = WC_ENV ? DEBUG_DEVICE_TOKEN : [DeviceUtil sharedInstance].deviceToken;
        if(!token) {
            token = DEBUG_DEVICE_TOKEN;
        }
        NSString *encodedUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                   (CFStringRef)self.wt.url,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8);

        self.url = [NSString stringWithFormat:NW_NEW_WCTASK_HTTP_GET_FORMAT, NW_SERVERHOST, NW_NEW_WCTASK_PATH, encodedUrl, self.wt.pattern, @(self.wt.patternCount), self.wt.type, token];
    }
    return self;
}

-(instancetype)initWithWCTaskToDelete:(WCTask *)wt{
    self = [super init];
    self.wt = wt;
    self.url = nil;
    if (self.wt) {
        NSString *token = WC_ENV ? DEBUG_DEVICE_TOKEN : [DeviceUtil sharedInstance].deviceToken;
        if(!token) {
            token = DEBUG_DEVICE_TOKEN;
        }

        NSString *encodedUrl = [self encodeUTF8:self.wt.url];
        
        self.url = [NSString stringWithFormat:NW_DEL_WCTASK_HTTP_GET_FORMAT, NW_SERVERHOST, NW_DEL_WCTASK_PATH, encodedUrl, self.wt.pattern, [self encodeUTF8:self.wt.type ], token];

    }
    return self;
}

-(NSString *)encodeUTF8:(NSString *)str{
    return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8 );
}

-(instancetype)initToGetWithDevice{
    self = [super init];
    NSString *token = WC_ENV ? DEBUG_DEVICE_TOKEN : [DeviceUtil sharedInstance].deviceToken;
    if(!token) {
        token = DEBUG_DEVICE_TOKEN;
    }
    
    self.url = [NSString stringWithFormat:NW_GET_WCTASK_HTTP_GET_FORMAT, NW_SERVERHOST, NW_GET_WCTASK_PATH,token];
    return self;
}

-(void)postCall:(id)data{
    [AlertUtil showAlertWithTitle:@"AWS updated" AndMsg:data AndCancelButtonTitle:@"OK"];
}

-(id)getUId{
    return self.url;
}

-(id)getURL{
    return self.url;
}

-(id)getPostData{
    return nil;
}

@end
