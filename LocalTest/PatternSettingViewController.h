//
//  PatternSettingViewController.h
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface PatternSettingViewController : UIViewController<UIPickerViewDelegate>
@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;
@property (retain, nonatomic) IBOutlet UIButton *jobDoneButton;
@property (retain, nonatomic) IBOutlet UIView *jobDoneAnimation;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) PageViewController *pageViewController;

@end
