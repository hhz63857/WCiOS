//
//  BackgroundUtil.m
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "BackgroundUtil.h"
#import "Constant.h"
#import <Accelerate/Accelerate.h>

@implementation BackgroundUtil

+(instancetype)sharedInstance{
    static BackgroundUtil *_sharedInstance;
    static dispatch_once_t m_token;
    dispatch_once(&m_token, ^{
        _sharedInstance = [[BackgroundUtil alloc] init];
    });
    return _sharedInstance;
}

-(void)randomSetBackImg
{
    int r = arc4random_uniform(BACKGROUND_IMAGE_POOL_SIZE);
    self.imgPath = [@"SF" stringByAppendingString:[@(r) stringValue]];
//    NSLog(@"set path %@", self.imgPath);
}

-(UIImage *)getBackgroundSourceImageWithBlur:(BOOL)blur
{
//    NSLog(@"get path %@", self.imgPath);
    UIImage *img = [UIImage imageNamed: self.imgPath];
    if (blur) {
        img = [self boxblurImage:img boxSize:5];
    }
    return img;
}

-(UIColor *)getBackgroundImageWithBlur:(BOOL)blur
{
    UIImage *img = [self getBackgroundSourceImageWithBlur:blur];
    return [UIColor colorWithPatternImage:img];
}

-(UIImage *)boxblurImage:(UIImage *)image boxSize:(int)boxSize {
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //create CGImageRef from vImage_Buffer output
    //1 - CGBitmapContextCreateImage -
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //2 CGImageCreate - alternative - has a leak
    
    /*
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, outBuffer.data, outBuffer.height * outBuffer.rowBytes, releasePixels);
     CGImageRef imageRef = CGImageCreate(outBuffer.width, outBuffer.height, 8, 32, outBuffer.rowBytes, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaLast, provider, NULL, NO, kCGRenderingIntentPerceptual);
     
     UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
     */
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
    
}

@end
