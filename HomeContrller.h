//
//  HomeContrller.h
//  LocalTest
//
//  Created by Huahan on 4/4/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomeContrller : NSObject

@property(nonatomic, readonly) UINavigationController *mainNavi;
@property(nonatomic) UINavigationController *mainNaviController;

+(HomeContrller *)sharedInstance;
-(void)setupMainNavigationControllerStack;
@end
