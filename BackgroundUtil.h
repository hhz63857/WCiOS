//
//  BackgroundUtil.h
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BackgroundUtil : NSObject
@property (strong, nonatomic) NSString *imgPath;

+(instancetype)sharedInstance;
-(UIImage *)blurWithCoreImage:(UIImage *)sourceImage :(CGRect)frame;
-(void)randomSetBackImg;
-(UIColor *)getBackgroundImageWithBlur:(BOOL)blur :(CGRect)frame;
-(UIImageView *)getBackgroundSourceImageViewWithBlur:(BOOL)blur :(CGRect)frame;
-(UIImage *)getBackgroundSourceImageWithBlur:(BOOL)blur :(CGRect)frame;
-(void)loadBackgroundImage :(UIView *)view;
@end
