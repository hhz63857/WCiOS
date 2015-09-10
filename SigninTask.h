//
//  SigninTask.h
//  LocalTest
//
//  Created by Huahan on 6/13/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NetworkCallContext.h"
#import "AsyncNetworkDelegate.h"

@interface SigninTask : NSObject<NetworkCallContext>
@property NSString *url;
-(instancetype)initWithUsername:(NSString *)userame pwd:(NSString *)pwd;

@end
