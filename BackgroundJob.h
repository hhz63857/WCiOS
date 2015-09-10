//
//  BackgroundJob.h
//  LocalTest
//
//  Created by Huahan on 9/7/15.
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


@interface BackgroundJob : NSObject
+(void)synchronizeWCWebPageWithWCTask;
@end
