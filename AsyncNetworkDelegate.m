//
//  AsyncNetworkDelegate.m
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AsyncNetworkDelegate.h"
#import "NetworkService.h"
#import "SQLiteDataService.h"
#import "NewsBuilder.h"

@implementation AsyncNetworkDelegate

+(void)startAsyncDownloadDataToDB:(id<NetworkCallContext> *)context
{
    static NSThread *_networkRequestThread = nil;
//    NSLog(@" new thread created : %@", [context getURL]);
    _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadAndParseAndSaveToDB:) object:(id)context];
    [_networkRequestThread start];
}

+(void)downloadAndParseAndSaveToDB:(id<NetworkCallContext> *)context
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworkingDownloader"];
//        NSLog(@"%@   delegate to thread =>   %@", [context getURL], [NSThread currentThread]);
        NSURL *nsurl = [NSURL URLWithString:[context getURL]];
//        NSLog(@"downloadAndParseAndSaveToDB %@", [context getURL]);
        NSString *htmlString = [NetworkService performStoreRequestWithURL:nsurl];
        //todo check status code
        if (htmlString != nil) {
            [context saveData:htmlString];
        }
    }
}
@end
