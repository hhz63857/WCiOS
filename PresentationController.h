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
@property (nonatomic) UIViewController *contentController;
@property (nonatomic) UIView *contentContainerView;
@property (nonatomic) NSMutableDictionary *VCs;
@property (nonatomic) NSMutableDictionary *presenters;
@property (nonatomic) NSMutableDictionary *menuContainerViews;

+(PresentationController *)sharedInstance;
-(void)setContentController:(UIViewController *)navi;

@end
