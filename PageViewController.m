//
//  PageViewController.m
//  LocalTest
//
//  Created by Huahan on 4/13/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "PageViewController.h"
#import "WelcomeViewController.h"
#import "WebViewController.h"
#import "PatternSettingViewController.h"
#import "LocalDataModel.h"
#define PAGE_COUNT 3
#define ENTITY_NAME @"WCTask"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];

    [self initViewControllers];

    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void) initViewControllers
{
    self.viewControllers = [[NSMutableArray alloc] initWithCapacity:PAGE_COUNT];

    //page 0 -> welcome page
    WelcomeViewController *wVC = [[WelcomeViewController alloc] init];
    self.viewControllers[0] = wVC;
    wVC.pageViewController = self;
    
    [self.pageController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    //page 1 -> embeded web page
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.pageViewController = self;
    [self.viewControllers addObject:webVC];

    //page 2 -> pattern setting page
    PatternSettingViewController *pVC = [[PatternSettingViewController alloc] init];
    pVC.pageViewController = self;
    [self.viewControllers addObject:pVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveNewWCTask {
    LocalDataModel *dm = [[LocalDataModel alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.newWCTaskUrl forKey:@"url"];
    [dict setValue:self.newWCTaskPattern forKey:@"pattern"];
    [dict setValue:self.newWCTaskType forKey:@"type"];
    
    NSManagedObject *task = [dm createRecordWithEnitityName:ENTITY_NAME Dict:dict];
    [dm saveRecord:task];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    NSLog(@"%zd", index);
    if(index >= [self.viewControllers count]) {
        return nil;
    }
    return [self.viewControllers objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == [self.viewControllers count]) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return PAGE_COUNT;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
