//
//  WebViewController.h
//  LocalTest
//
//  Created by Huahan on 4/14/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"
#import "NJKWebViewProgress.h"

@interface WebViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate, NJKWebViewProgressDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UITextField *urlTextField;
@property (retain, nonatomic) IBOutlet UIButton *dragableButton;
@property (strong, nonatomic) PageViewController *pageViewController;

@end
