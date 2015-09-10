//
//  SignupTask.h
//  LocalTest
//
//  Created by Huahan on 5/28/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkCallContext.h"
#import "AsyncNetworkDelegate.h"

@interface SignupTask : NSObject<NetworkCallContext>
@property NSString *url;
-(instancetype)initWithUsername:(NSString *)userame pwd:(NSString *)pwd;

@end
