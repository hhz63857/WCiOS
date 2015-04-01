//
//  main.m
//  MyLocations
//
//  Created by Matthijs on 08-10-13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "C1.h"
#import "TT.h"
#import "LocalDataManager.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSString *documentName = @"fd";
        NSURL *nsurl = [url URLByAppendingPathComponent:documentName];
        UIManagedDocument *doc = [[UIManagedDocument alloc] initWithFileURL:nsurl];
        LocalDataManager *lm = [[LocalDataManager alloc] initWithDoc:doc url:nsurl];
        if([fileManager fileExistsAtPath:[nsurl path] ]) {
            NSLog(@"exist");
            [doc openWithCompletionHandler:^(BOOL isSuccess) {
                NSLog(@"exist => handler");
                [lm testOnDoc:doc];
            }];
        } else {
            NSLog(@"inexist");
            [doc saveToURL:nsurl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL isSuccess) {
                if(isSuccess) {
                    NSLog(@"inexist => handler success");
                    [lm testOnDoc:doc];
                } else {
                    NSLog(@"inexist => handler failed");
                }
                NSLog(@"inexist => handler");
            }];
        }
        NSLog(@"end");
        while (YES) {
            NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:0.1];
            [[NSRunLoop currentRunLoop] runUntilDate:futureTime];
        }
        //	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
