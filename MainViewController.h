//
//  MainViewController.h
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UINavigationItem *headLabel;
@property(assign, nonatomic) UIView *bottomView;
@property(assign, nonatomic) UIScrollView *bottomScrollView;
@property UIView *tableView;
@property(assign, nonatomic) UIView *signUpView;
@property(assign, nonatomic) UIView *signInView;
+(instancetype)sharedInstance;
-(void)scrollDownScrollView;
-(void)refreshBGImage;
@end
