//
//  WebViewController.m
//  LocalTest
//
//  Created by Huahan on 4/14/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //webview
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:self.webView];
    
    //dragable button
    [self.view bringSubviewToFront:self.dragableButton];
    [self.view addSubview:self.dragableButton];
    
    UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.dragableButton addGestureRecognizer:pangr];
    [pangr release];
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


- (IBAction)moveOn:(id)sender {
    self.pageViewController.newWCTaskUrl = self.urlTextField.text;
    
    UIViewController *uVC = [self.pageViewController viewControllerAtIndex:2];
    NSArray *arr = [NSArray arrayWithObject:uVC];
    [self.pageViewController.pageController setViewControllers:arr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    self.urlTextField.text = [aWebView.request.mainDocumentURL absoluteString];
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
