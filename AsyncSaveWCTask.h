//
//  AsyncSaveWCTask.h
//  LocalTest
//
//  Created by Huahan on 5/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkCallContext.h"
#import "WCTask.h"
#import <UIKit/UIKit.h>

@interface AsyncSaveWCTask :NSObject<NetworkCallContext>
@property WCTask *wt;
@property NSString *url;
-(instancetype)initWithWCTask:(WCTask *)wt;
-(instancetype)initWithWCTaskToDelete:(WCTask *)wt;
-(instancetype)initToGetWithDevice;
@end
