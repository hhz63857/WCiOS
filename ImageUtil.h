//
//  ImageUtil.h
//  LocalTest
//
//  Created by Huahan on 4/24/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtil : UIWebView
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
+(UIImage*)captureScreen:(UIView*) viewToCapture;
@end
