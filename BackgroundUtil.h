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
-(void)randomSetBackImg;
-(UIColor *)getBackgroundImageWithBlur:(BOOL)blur;
-(UIImage *)getBackgroundSourceImageWithBlur:(BOOL)blur;
@end
