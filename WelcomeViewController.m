//
//  WelcomeViewController.m
//  LocalTest
//
//  Created by Huahan on 4/12/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WelcomeViewController.h"
#import "BackgroundUtil.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.welcomeLabel];
    [self.view addSubview:self.goButton];
    [self.view addSubview:self.introLabel];
    self.view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES :self.view.frame];
}

- (void)viewWillAppear:(BOOL)animated {
    [self performWelcomeLabel];
}

-(void)performWelcomeLabel
{
    self.welcomeLabel.text = @"WELCOME";
    self.welcomeLabel.animationDuration = 2;
    self.welcomeLabel.characterAnimationOffset = 0.5;
    
    self.welcomeLabel.text = @"WELCOME!";
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
    [_welcomeLabel release];
    [_introLabel release];
    [super dealloc];
}
@end
