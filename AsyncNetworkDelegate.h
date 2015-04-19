//
//  AsyncNetworkDelegate.h
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkCallContext.h"

@interface AsyncNetworkDelegate : NSObject

+(void)startAsyncDownloadDataToDB:(id<NetworkCallContext> *) context;
+(void)downloadAndParseAndSaveToDB:(id<NetworkCallContext> *) context;
@end
