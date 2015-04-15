//
//  AppDelegate.h
//  LocalTest
//
//  Created by Huahan Zhang on 3/30/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
#import "TestCollectionViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)TestViewController *testViewController;
//@property (strong,nonatomic)TestTableViewController *testTableViewController;
@property (strong,nonatomic)TestCollectionViewController *testCollectionViewController;
@property (strong,nonatomic)UINavigationController *navigationController;

@end

