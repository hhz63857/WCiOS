//
//  PresentationController.h
//  LocalTest
//
//  Created by Huahan on 4/4/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuViewControllerType){
    LEFT,
    RIGHT
};


@protocol MenuPresenter <NSObject>

@property(nonatomic) NSString *context;

@end


@interface PresentationController : UIViewController
@property (strong, nonatomic) UIViewController *contentController;
@property (strong, nonatomic) UIView *contentContainerView;
@property (strong, nonatomic) NSMutableDictionary *VCs;
@property (strong, nonatomic) NSMutableDictionary *presenters;
@property (strong, nonatomic) NSMutableDictionary *menuContainerViews;

+(PresentationController *)sharedInstance;
-(void)setContentController:(UIViewController *)navi;

@end
