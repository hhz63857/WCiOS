//
//  PresentationController.m
//  LocalTest
//
//  Created by Huahan on 4/4/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "PresentationController.h"

@interface PresentationController ()<UINavigationControllerDelegate>

@end

@implementation PresentationController

+(PresentationController *)sharedInstance{
    static PresentationController *_sharedInstance;
    static dispatch_once_t mutex_token;
    dispatch_once(&mutex_token, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
-(PresentationController *)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        //1, todo init image bundle
        //2,
        _VCs = [NSMutableDictionary dictionary];
        _presenters = [NSMutableDictionary dictionary];
        _menuContainerViews = [NSMutableDictionary dictionary];
        
        //3, create content container view
        _contentContainerView = ({
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            view;
        });
        
        int menuViewCount = 2;
        for (int i = 0; i < menuViewCount; i++) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            view.hidden = YES;
            view.clipsToBounds = YES;
            _menuContainerViews[@(i)] = view;
            [self.view addSubview:view];
        }
        [self.view addSubview:self.contentContainerView];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //todo other animation
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setMenuViewController:(UIViewController *)vc forType:(MenuViewControllerType)type withPresenter:(id<MenuPresenter>)presenter
{
    //presenter should be present when you set a menu view contoller
    
    //1, todo dismiss previously opend menu
    
    //2, remove existing controllers and presenters
    [self.VCs removeObjectForKey:@(type)];
    [self.presenters removeObjectForKey:@(type)];
    
    if (vc) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        navi.navigationBarHidden = YES;
        navi.delegate = self;
        self.VCs[@(type)] = navi;
    }
    
    if (presenter) {
        self.presenters[@(type)] = presenter;
        presenter.context = @"123";
        //todo presenter preparation for presentation
    }
}

-(UIViewController *)viewControllerWithType:(MenuViewControllerType)type
{
    return self.VCs[@(type)];
}

-(id<MenuPresenter>) presenterWithType:(MenuViewControllerType)type
{
    return self.presenters[@(type)];
}

-(void)setContentController:(UIViewController *)navi
{
    //1, todo notify observer
    //[self willChangeValueForKey:@"naviController"];
    
    //2,remove view and controller if diff
    if(_contentController && _contentController != navi) {
        [_contentController.view removeFromSuperview];
        [_contentController removeFromParentViewController];
    }
    
    //3,
    _contentController = navi;
    
    if (navi != nil) {
        [self.contentContainerView addSubview:self.contentController.view];
//        [self.addChildViewController:self.contentController];
        [self.contentController didMoveToParentViewController:self];
    }
    
    //4 todo update context
  
    //5,
//    [self didChangeValueForKey:@"naviController"];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"nothing");
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
