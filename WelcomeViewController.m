//
//  WelcomeViewController.m
//  LocalTest
//
//  Created by Huahan on 4/12/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.goButton.frame = CGRectMake(150, 400, 63, 59);
//    self.stepLabel.text = [@"STEP " stringByAppendingFormat:@"%d", self.index];
    [self.view addSubview:self.goButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickGo:(id)sender {
    UIViewController *uVC = [self.pageViewController viewControllerAtIndex:1];
    NSArray *arr = [NSArray arrayWithObject:uVC];
    [self.pageViewController.pageController setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_goButton release];
    [_stepLabel release];
    [super dealloc];
}
@end
