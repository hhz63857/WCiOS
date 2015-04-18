//
//  WCDelegate.m
//  LocalTest
//
//  Created by Huahan on 4/12/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCDelegate.h"
#import "WelcomeViewController.h"
#import "PageViewController.h"
#import "MainTableViewController.h"

@implementation WCDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    PageViewController *pvc = [[PageViewController alloc] init];
    MainTableViewController *mvc = [[MainTableViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = mvc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
