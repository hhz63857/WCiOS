//
//  WCTaskCellWrapper.h
//  LocalTest
//
//  Created by Huahan on 4/25/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCTask.h"
#import "MainTableViewCell.h"

@interface WCTaskCellWrapper : WCTask

@property(nonatomic, strong) UIWebView *webview;
@property(nonatomic, strong) MainTableViewCell *viewcell;
-(instancetype)initWithUrl:(NSString *)url Pattern:(NSString *)pattern Type:(NSString *)type PatternCount:(NSInteger) patternCount Nickname:(NSString *)nickname webView:(UIWebView *)webview mainTableViewCell:(MainTableViewCell *)viewcell;
@end
