//
//  MainViewController.m
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "PageViewController.h"
#import "WCDelegate.h"
#import "MainTableViewController.h"
#import "BackgroundUtil.h"
#import <GPUImage/GPUImage.h>
#import "JVFloatLabeledTextFieldViewController.h"
#import "NewTaskViewController.h"

@interface MainViewController ()
@property UIView *blurMask;
@property UIImageView *blurredBgImage;
@property UIView *tableView;
@property(weak, nonatomic) UIView *bottomView;
@property(weak, nonatomic) UIScrollView *bottomScrollView;
@end

@implementation MainViewController

@synthesize blurMask, blurredBgImage;

+(instancetype)sharedInstance{
    static MainViewController *_sharedInstance;
    static dispatch_once_t m_token;
    dispatch_once(&m_token, ^{
        _sharedInstance = [[MainViewController alloc] init];
    });
    return _sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setup];
}

-(void)loadView{
    [self setup];
}

-(void)setup
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    [self.view addSubview:navBar];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Tutorial" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Tasks"];
    [navItem setRightBarButtonItem:doneItem animated:YES];
    [navBar setItems:[NSArray arrayWithObject:navItem] animated:YES];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // slide view
    self.bottomView = [self createScrollView];
    [self.view addSubview: self.bottomView];
    
    // table view
    self.tableView = [self createTableView];
    [self.view addSubview: self.tableView];
    
    self.view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES];

    // Blurred with Core Image
    blurredBgImage.image = [self blurWithCoreImage:[[BackgroundUtil sharedInstance] getBackgroundSourceImageWithBlur:YES]];
    
    blurMask = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    blurMask.backgroundColor = [UIColor whiteColor];
    blurredBgImage.layer.mask = blurMask.layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (IBAction)add:(UIBarButtonItem *)sender {
    PageViewController *s = [[PageViewController alloc] init];
    UIWindow *window = [(WCDelegate *)[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = s;
    [window makeKeyAndVisible];
}

#pragma mark - Scroll View
- (UITableView *)createTableView
{
    UITableView *tableview = [MainTableViewController sharedInstance].tableView;
    tableview.frame = CGRectMake(0, 60, self.view.frame.size.width, 677 - 60 - 56 - 3);
//    tableview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    tableview.backgroundColor = [UIColor clearColor];
    return tableview;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
    blurMask.frame = CGRectMake(blurMask.frame.origin.x,
                                self.view.frame.size.height - 50 - scrollView.contentOffset.y,
                                blurMask.frame.size.width,
                                blurMask.frame.size.height + scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 56){
        [self.view bringSubviewToFront:self.tableView];
    } else {
        [self.view bringSubviewToFront:self.bottomView];
    }
}

-(void)scrollDownScrollView
{
//    CGPoint bottomOffset = CGPointMake(0, 57);
//    [self.bottomScrollView setContentOffset:bottomOffset animated:YES];
//    self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x,
//                                400,
//                                self.bottomView.frame.size.width,
//                                self.bottomView.frame.size.height);
    [self.bottomView release];

    self.bottomView = [self createScrollView];
    [self.view addSubview: self.bottomView];
}

- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    CGFloat reductionFactor = 1;
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width/reductionFactor, view.frame.size.height/reductionFactor));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, view.frame.size.width/reductionFactor, view.frame.size.height/reductionFactor) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage
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
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, self.view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, self.view.frame);
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
    
    //    GPUImageBoxBlurFilter *blurFilter = [[GPUImageBoxBlurFilter alloc] init];
    //    blurFilter.blurRadiusInPixels = 20.0;
    
    //    GPUImageiOSBlurFilter *blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    //    blurFilter.saturation = 1.5;
    //    blurFilter.blurRadiusInPixels = 30.0;
    
    return [blurFilter imageByFilteringImage: sourceImage];
}

- (UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    headerView.backgroundColor = [UIColor colorWithRed:229/255.0 green:39/255.0 blue:34/255.0 alpha:0.6];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    title.text = @"Dynamic Blur Demo";
    title.textColor = [UIColor colorWithWhite:1 alpha:1];
    [title setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [headerView addSubview:title];
    
    return headerView;
}

- (UIView *)createScrollView
{
    int topOffset = 50;
    int height = 667 - topOffset;
    int iniHeight = 56;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, topOffset, self.view.frame.size.width, height)];
    
    blurredBgImage = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [blurredBgImage setContentMode:UIViewContentModeScaleToFill];
    [containerView addSubview:blurredBgImage];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [containerView addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2 - 110);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    self.bottomScrollView = scrollView;
    
    UIView *slideContentView = [[UIView alloc] initWithFrame:CGRectMake(0, height - iniHeight, self.view.frame.size.width, height)];
    slideContentView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:slideContentView];
    
    UIImageView *slideUpImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 12, 4, 24, 22.5)];
    slideUpImage.image = [UIImage imageNamed:@"up-arrow.png"];
    [slideContentView addSubview:slideUpImage];

    UILabel *slideUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, self.view.frame.size.width, 50)];
    slideUpLabel.text = @"New Task";
    [slideUpLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [slideUpLabel setTextAlignment:NSTextAlignmentCenter];
    slideUpLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    [slideContentView addSubview:slideUpLabel];
    
    NewTaskViewController *floatingLabelController = [[NewTaskViewController alloc] initWithParentScrollView:scrollView];
//    [self addChildViewController:floatingLabelController];
    floatingLabelController.view.frame = CGRectMake(15, 100, self.view.frame.size.width - 30, 667 - 100 - 200);
    [slideContentView addSubview: floatingLabelController.view];
//    [floatingLabelController didMoveToParentViewController:self];

    return containerView;
}

@end
