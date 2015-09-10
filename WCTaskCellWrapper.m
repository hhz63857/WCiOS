//  DEPRECATED
//
//  WCTaskCellWrapper.m
//  LocalTest
//
//  Created by Huahan on 4/25/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCTaskCellWrapper.h"

@implementation WCTaskCellWrapper
@synthesize webview;
@synthesize viewcell;
-(instancetype)initWithUrl:(NSString *)url Pattern:(NSString *)pattern Type:(NSString *)type PatternCount:(NSInteger) patternCount Nickname:(NSString *)nickname webView:(UIWebView *)Webview mainTableViewCell:(MainTableViewCell *)Viewcell
{
    [super initWithUrl:url Pattern:pattern Type:type PatternCount:patternCount Nickname:nickname];
    if (self && webview && viewcell) {
        self.webview = Webview;
        self.viewcell = Viewcell;
    }
    return self;
}
@end
