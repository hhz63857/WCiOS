//
//  ArticleViewController.h
//  LocalTest
//
//  Created by Huahan on 4/4/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UITableViewController

//todo protocal
@property(nonatomic) id delegate;
-(ArticleViewController *)initWIthCategory:(NSString *)categoryName;

@end
