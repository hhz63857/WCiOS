//
//  WebViewController.m
//  LocalTest
//
//  Created by Huahan on 4/14/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WebViewController.h"
#import "BackgroundUtil.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController (){
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end


@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //webview
    [self requestDesktopVersionUrl:@"http://www.google.com"];
    
    [self.view addSubview:self.webView];
    
    //dragable button
    [self.view bringSubviewToFront:self.dragableButton];
    [self.view addSubview:self.dragableButton];
    
    UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.dragableButton addGestureRecognizer:pangr];
    [pangr release];
    
    [self.urlTextField setReturnKeyType:UIReturnKeyDone];
    self.urlTextField.delegate = self;
    
    _progressProxy = [[NJKWebViewProgress alloc] initWithParentVC:self];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    self.view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES];
 
    CGFloat progressBarHeight = 3.f;
    CGRect navigaitonBarBounds = self.webView.bounds;
    CGRect barFrame = CGRectMake(0, 170, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
//    _progressView.backgroundColor = [UIColor redColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
}

-(void)requestDesktopVersionUrl:(NSString *)theUrl{
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:theUrl]];
    NSString *desktopUAStr = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11";
    [rq setValue:desktopUAStr forHTTPHeaderField:@"User-Agent"];
    [self.webView loadRequest:rq];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.urlTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateChanged ||
        recognizer.state == UIGestureRecognizerStateEnded) {
        
        UIView *draggedButton = recognizer.view;
        CGPoint translation = [recognizer translationInView:self.view];
        
        CGRect newButtonFrame = draggedButton.frame;
        newButtonFrame.origin.x += translation.x;
        newButtonFrame.origin.y += translation.y;
        draggedButton.frame = newButtonFrame;
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    self.urlTextField.text = [self.webView.request.mainDocumentURL absoluteString];
}

- (IBAction)moveOn:(id)sender {
    self.pageViewController.newWCTaskUrl = self.urlTextField.text;
    
    UIViewController *uVC = [self.pageViewController viewControllerAtIndex:2];
    NSArray *arr = [NSArray arrayWithObject:uVC];
    [self.pageViewController.pageController setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToUrl:(id)sender {
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextField.text]]];
}
- (IBAction)goTo:(id)sender {
      [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextField.text]]];
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)preWebViewDidFinishLoad
{
    self.urlTextField.text = [self.webView.request.mainDocumentURL absoluteString];
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
    [_webView release];
    [_urlTextField release];
    [_dragableButton release];
    [super dealloc];
}
@end
