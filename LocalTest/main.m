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

int main(int argc, char * argv[])
{
    @autoreleasepool {
        //setup
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSLog(@"##%@", url);
        
        //9 regex test
//        [RegexUtilTest testRegex];
        
        //8 WC
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([WCDelegate class]));
        
        //7 test img
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([ImgAppDelegate class]));
        
        //6 map
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([MapAppDelegate class]));
        
        //4, download and save
        //[NS_FSTestSuite downloadAndStore];
        
        //3. test network call
        //        [NSTestSuite makeNetworkCall];
        
        //2. file test
        FSTestSuit *fs = [[FSTestSuit alloc] init];
        [fs startWithModel];
        [fs testUpdate];
        
        //1, start view
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
