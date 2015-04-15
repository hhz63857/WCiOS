//
//  WelcomeViewController.h
//  LocalTest
//
//  Created by Huahan on 4/12/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface WelcomeViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *goButton;
@property (retain, nonatomic) IBOutlet UILabel *stepLabel;
@property (nonatomic) PageViewController *pageViewController;
@property NSInteger index;
@end
