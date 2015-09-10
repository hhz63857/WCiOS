//
//  DeviceUtil.h
//  LocalTest
//
//  Created by Huahan on 5/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUtil : NSObject
@property (strong, nonatomic) NSString *deviceToken;

+ (NSString *)deviceUUID;
+(instancetype)sharedInstance;
@end
