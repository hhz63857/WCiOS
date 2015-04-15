//
//  ImgViewController.m
//  LocalTest
//
//  Created by Huahan on 4/10/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "ImgViewController.h"

@interface ImgViewController ()

@end

@implementation ImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://s3-media2.fl.yelpassets.com/bphoto/LVgGlinHHW40d7Up_nf4uw/o.jpg"];
    [self loadImage:url];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    UIImage *croppedImg = nil;
    CGRect cropRect = CGRectMake(0, 0, 600, 600); //set your rect size.
    croppedImg = [self croppIngimageByImageName:image toRect:cropRect];

    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:croppedImg waitUntilDone:YES];
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (void)placeImageInUI:(UIImage *)image
{
    self.imgView.image = image;
    self.scrollView.contentSize = CGSizeMake(self.imgView.frame.size.width, self.imgView.frame.size.height);
    
    [self.scrollView addSubview:self.imgView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)dealloc {
    [_imgView release];
    [_imgView release];
    [_scrollView release];
    [super dealloc];
}
@end
