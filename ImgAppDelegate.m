//
//  ImgAppDelegate.m
//  LocalTest
//
//  Created by Huahan on 4/10/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "ImgAppDelegate.h"
#import "ImgViewController.h"

@implementation ImgAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ImgViewController *imgVC = [[ImgViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = imgVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgVC;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
    
}

@end
