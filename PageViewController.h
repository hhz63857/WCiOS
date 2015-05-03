//
//  PageViewController.h
//  LocalTest
//
//  Created by Huahan on 4/13/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCTask.h"
#import "WCWebPage.h"

@interface PageViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSString *newWCTaskUrl;
@property (strong, nonatomic) NSString *newWCTaskPattern;
@property (strong, nonatomic) NSString *newWCTaskType;
@property (strong, nonatomic) NSString *newWCTaskNickname;
+(PageViewController *)sharedInstance;
-(void)saveNewWCTask;
@end
