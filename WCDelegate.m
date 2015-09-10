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
#import "DeviceUtil.h"
#import "AsyncGetWCTask.h"
#import "AsyncNetworkDelegate.h"

@implementation WCDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[BackgroundUtil sharedInstance] randomSetBackImg];
    [AsyncNetworkDelegate syncUploadDataByHTTPGet:[[AsyncGetWCTask alloc] initToGetWithDevice]];

    [[MainTableViewController sharedInstance] refreshAllAsyn];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    //todo check see if show tutorial
    self.window.rootViewController = [MainViewController sharedInstance];
    [self.window makeKeyAndVisible];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---          %@", token);
    [DeviceUtil sharedInstance].deviceToken = token;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

@end
