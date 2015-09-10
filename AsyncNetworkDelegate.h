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
+(void)uploadDataByHTTPGet:(id<NetworkCallContext> *) context;
+(void)uploadDataByHTTPPost:(id<NetworkCallContext> *) context;
+(void)syncUploadDataByHTTPGet:(id<NetworkCallContext> *) context;
@end
