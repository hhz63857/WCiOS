//
//  DetailWebViewController.m
//  LocalTest
//
//  Created by Huahan on 4/22/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "DetailWebViewController.h"
#import "WCDelegate.h"
#import "MainViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface DetailWebViewController ()
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:self.webview];
    self.webview.delegate = self;
    
    _progressProxy = [[NJKWebViewProgress alloc] initWithParentVC:self];
    self.webview.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 3.f;
    CGRect navigaitonBarBounds = self.webview.bounds;
    CGRect barFrame = CGRectMake(0, 20, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webview highlightAllOccurencesOfString:self.pattern];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithUrl:(NSString *)url andPattern:(NSString*)pattern
{
    self = [super init];
    self.url = url;
    self.pattern = pattern;
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webview stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (IBAction)back:(id)sender {
    UIWindow *window = [(WCDelegate *)[[UIApplication sharedApplication] delegate] window];
    MainViewController *mvc = [MainViewController sharedInstance];
    window.rootViewController = mvc;
    [window makeKeyAndVisible];
    
//    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    [window insertSubview:mvc.view aboveSubview:window];
}

- (void)dealloc {
}
@end
