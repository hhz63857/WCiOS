//
//  networkUtil.h
//  LocalTest
//
//  Created by Huahan on 5/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
#import "WCTask.h"
#import "WCWebPage.h"
#import "MainTableViewController.h"
#import "AsyncSaveWCTask.h"
#import "AsyncNetworkDelegate.h"
#import "Constant.h"

@interface NetworkUtil : NSObject
+(void)uploadDataUrl:(NSString *)url pattern:(NSString *)pattern type:(NSString *)type patternCount:(NSInteger)patternCount nickname:(NSString *)nickname;
+(void)signUpDone:(NSString *)username :(NSString *)pwd;
+(void)signInDone:(NSString *)username :(NSString *)pwd;
@end
