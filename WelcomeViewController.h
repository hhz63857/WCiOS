//
//  WelcomeViewController.h
//  LocalTest
//
//  Created by Huahan on 4/12/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"
#import <TOMSMorphingLabel/TOMSMorphingLabel.h>

@interface WelcomeViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *goButton;
@property (retain, nonatomic) IBOutlet UILabel *stepLabel;
@property (strong, nonatomic) PageViewController *pageViewController;
@property (retain, nonatomic) IBOutlet TOMSMorphingLabel *welcomeLabel;
@property (retain, nonatomic) IBOutlet UILabel *introLabel;
@property NSInteger index;
@end
