//
//  DetailWebViewController.h
//  LocalTest
//
//  Created by Huahan on 4/22/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchWebView.h"

@interface DetailWebViewController : UIViewController<UIWebViewDelegate>
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *pattern;
@property (retain, nonatomic) IBOutlet SearchWebView *webview;

-(instancetype)initWithUrl:(NSString *)url andPattern:(NSString*)pattern;
@end
