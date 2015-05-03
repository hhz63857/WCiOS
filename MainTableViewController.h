//
//  MainTableViewController.h
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface MainTableViewController : UITableViewController<UIBarPositioning, UIScrollViewDelegate>
@property(strong, nonatomic) NSMutableArray *WCTasks;
@property(strong, nonatomic) NSMutableArray *WCPages;
@property(strong, nonatomic) UIRefreshControl *refreshControl;

+(MainTableViewController *)sharedInstance;
//-(void) addTaskWithUrl:(NSString *)url Patterns:(NSString *)patterns Type:(NSString *)type;
-(void) refreshAllAsyn;
@end
