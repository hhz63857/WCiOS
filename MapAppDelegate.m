//
//  MapAppDelegate.m
//  LocalTest
//
//  Created by Huahan on 4/7/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MapAppDelegate.h"
#import "MapViewController.h"

@import MapKit;
@implementation MapAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // value is a BOOL
    NSString * const TrackLocationInBackgroundPrefsKey;
    
    // value is a CLLocationAccuracy (double)
    NSString * const LocationTrackingAccuracyPrefsKey;
    
    // value is a BOOL
    NSString * const PlaySoundOnLocationUpdatePrefsKey;
    

    // it is important to registerDefaults as soon as possible,
    // because it can change so much of how your app behaves
    //
    NSMutableDictionary *defaultsDictionary = [[NSMutableDictionary alloc] init];
    
    // by default we track the user location while in the background
    [defaultsDictionary setObject:@YES forKey:TrackLocationInBackgroundPrefsKey];
    
    // by default we use the best accuracy setting (kCLLocationAccuracyBest)
    [defaultsDictionary setObject:@(kCLLocationAccuracyBest) forKey:LocationTrackingAccuracyPrefsKey];
    
    // by default we play a sound in the background to signify a location change
    [defaultsDictionary setObject:@YES forKey:PlaySoundOnLocationUpdatePrefsKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsDictionary];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MapViewController *mapVC = [[MapViewController alloc] init];
    self.mapNaviController = [[UINavigationController alloc] initWithRootViewController:mapVC];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = self.mapNaviController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
