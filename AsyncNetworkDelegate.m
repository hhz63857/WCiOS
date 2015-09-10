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

+(void)startNewThreadWithContext:(id<NetworkCallContext> *)context type:(SEL)typeSelector
{
    static NSThread *_networkRequestThread = nil;
    _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:typeSelector object:(id)context];
    [_networkRequestThread start];
}

+(void)startAsyncDownloadDataToDB:(id<NetworkCallContext> *)context
{
    [self startNewThreadWithContext:context type:@selector(HTTPGet:)];
}

+(void)HTTPGet:(id<NetworkCallContext> *)context
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworkingDownloader"];
//        NSLog(@"%@   delegate to thread =>   %@", [context getURL], [NSThread currentThread]);
        if (![context getURL]) {
            NSLog(@"url empty");
            return;
        }
        NSURL *nsurl = [NSURL URLWithString:[context getURL]];
        NSLog(@"http calling  %@", [context getURL]);
        NSString *htmlString = [NetworkService performStoreRequestWithURL:nsurl];
        //todo check status code
        if (htmlString != nil) {
            [context postCall:htmlString];
        }
    }
}

+(void)HTTPPost:(id<NetworkCallContext> *)context
{
    @autoreleasepool {
        NSString *post = [context getPostData];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        [request setURL:[NSURL URLWithString:[context getURL]]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:context];
        if(conn) {
            NSLog(@"Connection Successful");
        } else {
            NSLog(@"Connection could not be made");
        }
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"~~~~~ Status code: %d", [response statusCode]);
    }
}

+(void)uploadDataByHTTPGet:(id<NetworkCallContext> *) context
{
    [self startNewThreadWithContext:context type:@selector(HTTPGet:)];
}

+(void)uploadDataByHTTPPost:(id<NetworkCallContext> *) context
{
    [self startNewThreadWithContext:context type:@selector(HTTPPost:)];
}

+(void)syncUploadDataByHTTPGet:(id<NetworkCallContext> *) context
{
    [self HTTPGet:context];
}

@end
