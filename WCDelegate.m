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
#import "MainViewController.h"
#import "BackgroundUtil.h"

@implementation WCDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[BackgroundUtil sharedInstance] randomSetBackImg];
    
    [[MainTableViewController sharedInstance] refreshAllAsyn];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    //todo check see if show tutorial
    self.window.rootViewController = [MainViewController sharedInstance];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
