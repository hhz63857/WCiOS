//
//  HomeContrller.m
//  LocalTest
//
//  Created by Huahan on 4/4/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "HomeContrller.h"
#import "ArticleViewController.h"

@implementation HomeContrller

+(HomeContrller *)sharedInstance{
    static HomeContrller *_sharedInstance;
    static dispatch_once_t m_token;
    dispatch_once(&m_token, ^{
        _sharedInstance = [[HomeContrller alloc] init];
    });
    return _sharedInstance;
}

-(void)setupMainNavigationControllerStack
{
    NSString *defaultCategory = @"ALL";
    //1, todo check category
    
    //2, auto create a base new stream controller. it can either be a newsfeed controller or a category swipe controller
    UIViewController *baseController = [self createBaseControllerWithCategory: defaultCategory];
    
    //3 todo SIDE_SWIPE
    
    self.mainNaviController = [[UINavigationController alloc] initWithRootViewController:baseController];
}

-(UIViewController *)createBaseControllerWithCategory:(NSString *)categoryName
{
    UIViewController *ret = nil;
#ifdef SIDE_SWIPE
    return nil;
#else
    ArticleViewController *ac = [[ArticleViewController alloc] initWIthCategory:categoryName];
    ac.delegate = self;
    return ac;
#endif
    return ret;
}

@end
