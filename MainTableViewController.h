//
//  MainTableViewController.h
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface MainTableViewController : UITableViewController
@property(strong, nonatomic) NSArray *WCTasks;

+(MainTableViewController *)sharedInstance;
-(void) addTaskWithUrl:(NSString *)url Patterns:(NSString *)patterns Type:(NSInteger)type;
-(void) refreshAllAsyn;
@end
