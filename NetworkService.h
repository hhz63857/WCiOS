//
//  NetworkService.h
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (NSString *)performStoreRequestWithURL:(NSURL *)url;
+ (NSDictionary *)parseJSON:(NSString *)jsonString;

@end
