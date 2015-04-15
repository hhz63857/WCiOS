//
//  WebViewController.h
//  LocalTest
//
//  Created by Huahan on 4/14/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UITextField *urlTextField;
@property (retain, nonatomic) IBOutlet UIButton *dragableButton;
@property (nonatomic) PageViewController *pageViewController;

@end
