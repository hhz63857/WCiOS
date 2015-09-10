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
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "KLCPopup.h"
#import "NetworkUtil.h"
#import "Constant.h"

@interface MainViewController (){
    UIImage *tempBlurImg;
    int scrollViewBGContentHeight;
}
@property UIView *blurMask;
@property UIImageView *blurredBgImage;
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
    int headerHeight = 40;
    int headBarHeight = 20;

    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrollViewBGContentHeight = self.view.frame.size.height - MAIN_VIEW_TOP_HEIGHT;
    UIImageView * iv =  [[BackgroundUtil sharedInstance]  getBackgroundSourceImageViewWithBlur:YES :self.view.frame];
    [self.view addSubview:iv];
    
    int loginHeaderHeight = 0;
    BOOL showLoginHeader = false;
    
    if (showLoginHeader) {
        loginHeaderHeight = 30;
        [self.view addSubview:[self createLoginHeaderView:headBarHeight :loginHeaderHeight]];
    }
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, loginHeaderHeight + headBarHeight, self.view.frame.size.width, headerHeight)];
    [self.view addSubview:navBar];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Tutorial" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Tasks"];
//    [navItem setRightBarButtonItem:doneItem animated:YES];
    [navBar setItems:[NSArray arrayWithObject:navItem] animated:YES];
    
//    [[BackgroundUtil sharedInstance] loadBackgroundImage: self.view];

    // table view
    self.tableView = [self _createTableView:loginHeaderHeight + headBarHeight + headerHeight];
    [self.view addSubview: self.tableView];
//    self.view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES :self.view.frame];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setupScrollView];
    [self.view bringSubviewToFront:self.tableView];
}

-(void)setupScrollView
{
    // slide view
    self.bottomView = [self createScrollView];
    [self.view addSubview: self.bottomView];
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
- (UITableView *)_createTableView:(int)yOffset
{
    UITableView *tableview = [MainTableViewController sharedInstance].tableView;
    tableview.frame = CGRectMake(0, yOffset, self.view.frame.size.width, self.view.frame.size.height - yOffset - 56 - 3);
//    tableview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    tableview.backgroundColor = [UIColor clearColor];
    return tableview;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f", scrollView.contentOffset.y);
    blurMask.frame = CGRectMake(blurMask.frame.origin.x,
                                scrollViewBGContentHeight - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT - scrollView.contentOffset.y,
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
    [self.bottomView removeFromSuperview];
    [self.bottomView release];
    [self setupScrollView];

    [self.view bringSubviewToFront:self.tableView];
}

-(void)setupBlurredBGImage
{
    // Blurred with Core Image
    tempBlurImg = [[BackgroundUtil sharedInstance] getBackgroundSourceImageWithBlur:YES :CGRectMake(0, 0, self.view.frame.size.width, scrollViewBGContentHeight)];
    
    blurredBgImage = [[UIImageView  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollViewBGContentHeight)];
    blurredBgImage.image = tempBlurImg;

    blurMask = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewBGContentHeight - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT, self.view.frame.size.width, MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT)];
    blurMask.backgroundColor = [UIColor whiteColor];
    blurredBgImage.layer.mask = blurMask.layer;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.frame;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [blurredBgImage addSubview:blurEffectView];
}

-(void)refreshBGImage
{
//    [self setupScrollView];
//    [self.view bringSubviewToFront:self.tableView];
}

- (UIView *)createScrollView
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_VIEW_TOP_HEIGHT, self.view.frame.size.width, scrollViewBGContentHeight)];
    
    [self setupBlurredBGImage];
    [containerView addSubview:blurredBgImage];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scrollViewBGContentHeight)];
    [containerView addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollViewBGContentHeight * 2 - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT);
//    scrollView.contentOffset = CGPointMake(0, -(scrollViewBGContentHeight - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT));
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    self.bottomScrollView = scrollView;
    
    UIView *slideContentView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewBGContentHeight - MAIN_VIEW_SCROLL_VIEW_INIT_HEIGHT, self.view.frame.size.width, scrollViewBGContentHeight)];
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

- (UIView *)createLoginHeaderView:(int)yOffset :(int)height
{
    int buttonWidth = (self.view.frame.size.width - 10) / 2;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, self.view.frame.size.width, height)];
    
    UIButton *signUpButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [headerView addSubview:signUpButton];
    signUpButton.translatesAutoresizingMaskIntoConstraints = NO;
    [signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];

    UIButton *signInButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [headerView addSubview:signInButton];
    signInButton.translatesAutoresizingMaskIntoConstraints = NO;
    [signInButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [headerView addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[signUpButton(==buttonWidth)]-(xMargin)-[div1]-(xMargin)-[signInButton(==buttonWidth)]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(20), @"buttonWidth":@(buttonWidth)} views:NSDictionaryOfVariableBindings(signUpButton, div1, signInButton)]];
    
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[signUpButton(==buttonHeight)]|" options:0 metrics:@{@"buttonHeight": @(height)} views:NSDictionaryOfVariableBindings(signUpButton)]];

    [headerView addConstraint:[NSLayoutConstraint constraintWithItem:signUpButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:div1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [headerView addConstraint:[NSLayoutConstraint constraintWithItem:signUpButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:signInButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    headerView.backgroundColor = [UIColor clearColor];

    return headerView;
}

typedef NS_ENUM(NSInteger, FieldTag) {
    FieldTagHorizontalLayout = 1001,
    FieldTagVerticalLayout,
    FieldTagMaskType,
    FieldTagShowType,
    FieldTagDismissType,
    FieldTagBackgroundDismiss,
    FieldTagContentDismiss,
    FieldTagTimedDismiss,
};

-(void)signUp
{
    self.signUpView = [self createSignUpView:450];
    [self generatePopupView:self.signUpView];
    [self.view addSubview: self.signUpView];
}

-(void)generatePopupView:(UIView *)view{
    bool _shouldDismissOnBackgroundTouch = YES;
    bool _shouldDismissOnContentTouch = NO;
    bool _shouldDismissAfterDelay = NO;
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeSlideInFromTop
                                         dismissType:KLCPopupDismissTypeSlideOutToTop
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:_shouldDismissOnBackgroundTouch
                               dismissOnContentTouch:_shouldDismissOnContentTouch];
    
    if (_shouldDismissAfterDelay) {
        [popup showWithLayout:layout duration:2.0];
    } else {
        [popup showWithLayout:layout];
    }
}

JVFloatLabeledTextField* signupUsernameField;
JVFloatLabeledTextField* signinUsernameField;
JVFloatLabeledTextField* signupPwdField;
JVFloatLabeledTextField* signinPwdField;

-(UIView *)createSignUpView :(int) height
{
    UIView *signUpView = [[UIView alloc] initWithFrame:CGRectMake(40, 80, self.view.frame.size.width - 80, height)];
    signUpView.backgroundColor = [UIColor whiteColor];
    
    CGFloat kJVFieldFontSize = 16.0f;
    CGFloat kDoneLabelFontSize = 20.0f;
    CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

    //user name
    signupUsernameField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    signupUsernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"User Name", @"")
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    signupUsernameField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    signupUsernameField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    UIColor *floatingLabelColor = [UIColor brownColor];
    signupUsernameField.floatingLabelTextColor = floatingLabelColor;
    signupUsernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [signUpView addSubview:signupUsernameField];
    signupUsernameField.translatesAutoresizingMaskIntoConstraints = NO;
    signupUsernameField.keepBaseline = 1;
    signupUsernameField.delegate = self;
    [signupUsernameField setReturnKeyType:UIReturnKeyDone];
    
    //pwd
    signupPwdField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    signupPwdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password", @"")
                                                                         attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    signupPwdField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    signupPwdField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    signupPwdField.floatingLabelTextColor = floatingLabelColor;
    [signUpView addSubview:signupPwdField];
    signupPwdField.translatesAutoresizingMaskIntoConstraints = NO;
    signupPwdField.delegate = self;
    [signupPwdField setReturnKeyType:UIReturnKeyDone];

    // Done button
    UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    doneLabel.text = @"Sign Up";
    doneLabel.font = [UIFont systemFontOfSize:kDoneLabelFontSize];
    doneLabel.userInteractionEnabled = YES;
    doneLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tapGestureDone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signUpDone)];
    [doneLabel addGestureRecognizer:tapGestureDone];
    [signUpView addSubview:doneLabel];
    doneLabel.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [signUpView addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [signUpView addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;

    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[signupUsernameField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(signupUsernameField)]];

    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[signupPwdField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(signupPwdField)]];

    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[doneLabel]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(doneLabel)]];

    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div2)]];

    [signUpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(xMargin)-[signupUsernameField(==minHeight)][div1(1)][signupPwdField(==minHeight)][div2(1)][doneLabel]-(xMargin)-|" options:0 metrics:@{@"minHeight": @(55), @"xMargin": @(80)} views:NSDictionaryOfVariableBindings(signupUsernameField, div1, signupPwdField, div2, doneLabel)]];
    
    return signUpView;
}

-(void)signIn
{
    self.signInView = [self createSignInView:450];
    [self generatePopupView:self.signInView];
    [self.view addSubview:self.signInView];
}

-(UIView *)createSignInView :(int) height
{
    UIView *signInView = [[UIView alloc] initWithFrame:CGRectMake(40, 80, self.view.frame.size.width - 80, height)];
    signInView.backgroundColor = [UIColor whiteColor];
    
    CGFloat kJVFieldFontSize = 16.0f;
    CGFloat kDoneLabelFontSize = 20.0f;
    CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
    
    //user name
    signinUsernameField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    signinUsernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"User Name", @"")
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    signinUsernameField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    signinUsernameField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    UIColor *floatingLabelColor = [UIColor brownColor];
    signinUsernameField.floatingLabelTextColor = floatingLabelColor;
    signinUsernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [signInView addSubview:signinUsernameField];
    signinUsernameField.translatesAutoresizingMaskIntoConstraints = NO;
    signinUsernameField.keepBaseline = 1;
    signinUsernameField.delegate = self;
    [signinUsernameField setReturnKeyType:UIReturnKeyDone];
    
    //pwd
    signinPwdField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectZero];
    signinPwdField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password", @"")
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    signinPwdField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    signinPwdField.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    signinPwdField.floatingLabelTextColor = floatingLabelColor;
    [signInView addSubview:signinPwdField];
    signinPwdField.translatesAutoresizingMaskIntoConstraints = NO;
    signinPwdField.delegate = self;
    [signinPwdField setReturnKeyType:UIReturnKeyDone];
    
    // Done button
    UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    doneLabel.text = @"Sing In";
    doneLabel.font = [UIFont systemFontOfSize:kDoneLabelFontSize];
    doneLabel.userInteractionEnabled = YES;
    doneLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tapGestureDone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signInDone)];
    [doneLabel addGestureRecognizer:tapGestureDone];
    [signInView addSubview:doneLabel];
    doneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div1 = [UIView new];
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [signInView addSubview:div1];
    div1.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *div2 = [UIView new];
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [signInView addSubview:div2];
    div2.translatesAutoresizingMaskIntoConstraints = NO;
    
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[signinUsernameField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(signinUsernameField)]];
    
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[signinPwdField]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(signinPwdField)]];
    
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(xMargin)-[doneLabel]-(xMargin)-|" options:NSLayoutFormatAlignAllCenterY metrics:@{@"xMargin": @(40)} views:NSDictionaryOfVariableBindings(doneLabel)]];
    
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div1)]];
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[div2]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(div2)]];
    
    [signInView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(xMargin)-[signinUsernameField(==minHeight)][div1(1)][signinPwdField(==minHeight)][div2(1)][doneLabel]-(xMargin)-|" options:0 metrics:@{@"minHeight": @(55), @"xMargin": @(80)} views:NSDictionaryOfVariableBindings(signinUsernameField, div1, signinPwdField, div2, doneLabel)]];
    
    return signInView;
}

-(void)signUpDone{
//    [self.signUpView removeFromSuperview];
    [NetworkUtil signUpDone:signupUsernameField.text :signupPwdField.text];
}

-(void)signInDone{
//    [self.signInView removeFromSuperview];
    [NetworkUtil signInDone:signinUsernameField.text :signinPwdField.text];
}

@end
