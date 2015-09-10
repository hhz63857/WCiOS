//
//  main.m
//  MyLocations
//
//  Created by Matthijs on 08-10-13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTestSuit.h"
#import "AppDelegate.h"
#import "NSTestSuite.h"
#import "NS+FSTestSuite.h"
#import "MapAppDelegate.h"
#import "ImgAppDelegate.h"
#import "WCDelegate.h"
#import "RegexUtilTest.h"
#import "DataModelTest.h"
#import "BackgroundUtil.h"
#import "BackgroundJob.h"

int tests() {
    
    return -1;
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        //setup
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSLog(@"##%@", url);

        [BackgroundJob synchronizeWCWebPageWithWCTask];
        
        //11 test arr operation
//        NSMutableArray *arr = [[NSMutableArray alloc] init];
//        [arr addObject:@"123"];
//        [arr addObject:@"2123"];
//        [arr removeObjectAtIndex:1];
//        
        //10 test rand string
//        int r = arc4random_uniform(10);
//        NSString *imgPath = @"1333";
//        imgPath = [@"SF" stringByAppendingString:[@(r) stringValue]];
//        NSLog(@"%@", imgPath);
//        
        //9 regex test
//        [RegexUtilTest testRegex];
        
        //8 WC
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([WCDelegate class]));
        
        //7 test img
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([ImgAppDelegate class]));
        
        //6 map
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([MapAppDelegate class]));
        
        //4, download and save
        //[NS_FSTestSuite downloadAndStore];
        
        //3. test network call
//        [NSTestSuite makeNetworkCall];
        
        //2. file test
//        FSTestSuit *fs = [[FSTestSuit alloc] init];
//        [fs testSaveDirectly];
//        [fs startWithModel];
//        [fs testUpdate];
//        [fs testExePredication];
//        [DataModelTest startNTest];
//        [DataModelTest testSharedInstances];
        
        //1, start view
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
