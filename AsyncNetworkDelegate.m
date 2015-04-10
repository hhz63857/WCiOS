//
//  AsyncNetworkDelegate.m
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AsyncNetworkDelegate.h"
#import "NetworkService.h"
#import "LocalDataModel.h"
#import "NewsBuilder.h"

@implementation AsyncNetworkDelegate

+(void)startAsyncDownloadDataToDB
{
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadAndParseAndSaveToDB) object:nil];
        [_networkRequestThread start];
    });
}

+(void)downloadAndParseAndSaveToDB
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworkingDownloader"];

        NSString *url = @"https://newsdigest-yql.media.yahoo.com/v2/digest?date=2015-04-01";
        NSURL *nsurl = [NSURL URLWithString:url];
        NSString *jsonString = [NetworkService performStoreRequestWithURL:nsurl];
        if (jsonString != nil) {
            NSDictionary *dict = [NetworkService parseJSON:jsonString];
            if (dict != nil) {
                LocalDataModel *dm = [[LocalDataModel alloc] init];
                
                NSArray *arr = [NewsBuilder parse:dict];
                if (arr != nil) {
                    for (NSDictionary* dic in arr) {
                        NSManagedObject *news1 = [dm createRecordWithEnitityName:@"News" Dict:
                                                  dic];
                        [dm saveRecord:news1];
                    }
                }
            }
        }
    }
}

@end
