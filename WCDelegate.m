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
    [[MainTableViewController sharedInstance] refreshAllAsyn];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    //todo check see if show tutorial
    self.window.rootViewController = [MainTableViewController sharedInstance];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
