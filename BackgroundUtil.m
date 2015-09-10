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
#import <GPUImage/GPUImage.h>

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

//-(void)loadBackgroundImage :(UIView *)view
//{
//    UIImage* bgImg = [[BackgroundUtil sharedInstance] getBackgroundSourceImageWithBlur:YES :view.frame];
//    UIImageView *background = [[UIImageView alloc] initWithImage: bgImg];
//    [view addSubview:background];
//    [view sendSubviewToBack:background];
//    view.contentMode = UIViewContentModeScaleAspectFit;
//}

-(UIImageView *)getBackgroundSourceImageViewWithBlur:(BOOL)blur :(CGRect)frame
{
    // Blurred with Core Image
    UIImage * tempBlurImg = [[BackgroundUtil sharedInstance] getBackgroundSourceImageWithBlur:YES :frame];
    
    UIImageView *blurredBgImage = [[UIImageView alloc] initWithFrame:frame];
    blurredBgImage.contentMode = UIViewContentModeScaleToFill;
    blurredBgImage.image = tempBlurImg;
    
//    UIView * blurMask = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewBGContentHeight - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT, self.view.frame.size.width, MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT)];
//    blurMask.backgroundColor = [UIColor whiteColor];
//    blurredBgImage.layer.mask = blurMask.layer;
    return blurredBgImage;
}

-(UIImage *)getBackgroundSourceImageWithBlur:(BOOL)blur :(CGRect)frame
{
//    return [self _getBackgroundSourceImageWithBlur:blur :frame];
    return [self _imageWithColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
}

-(UIImage *)_getBackgroundSourceImageWithBlur:(BOOL)blur :(CGRect)frame
{
    frame = [[UIScreen mainScreen] bounds];
//    NSLog(@"get path %@", self.imgPath);
    UIImage *img = [UIImage imageNamed: self.imgPath];
    if (blur) {
        img = [self boxblurImage:img boxSize:1];
//        img = [self blurWithCoreImage:img :frame];
    }
    return img;
}

-(UIImage *)_imageWithColor:(UIColor *)color
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(UIColor *)getBackgroundImageWithBlur:(BOOL)blur :(CGRect)frame
{
//    return [UIColor blackColor];
    UIImage *img = [self getBackgroundSourceImageWithBlur:blur :frame];
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


- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage :(CGRect)frame
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@30 forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)blurWithGPUImage:(UIImage *)sourceImage
{
    GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 30.0;
    
    return [blurFilter imageByFilteringImage: sourceImage];
}
@end
