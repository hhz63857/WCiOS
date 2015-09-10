//
//  MainTableViewCell.m
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainTableViewCell.h"
#import "DateFormatUtil.h"
#import "ImageUtil.h"
#import "WCWebPage.h"
#import "DataModel.h"
#import "Constant.h"
#import "NamingUtil.h"

@interface MainTableViewCell(){
    NSData *screenShot;
    NSString *url;
}
@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void) initWithWCTask:(WCTask *)wctask
{
    if (wctask != nil && wctask.url != nil) {
        [self updateLastUpdateLabel:wctask];
        self.title.text = [NamingUtil getNickName:wctask];
        self.webPreview.delegate = self;
        
        //screenshot and save image
        url = wctask.url;
        screenShot = [self readImageFromWCWebpage:url];

        if (!screenShot) {
            [self.webPreview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wctask.url]]];
        }
        
        wctask.contextCell = self;
//        [wctask setContextCell:self];
    }
}

-(void)updateLastUpdateLabel:(WCTask *)wctask
{
    self.updateInfo.text = wctask.lastUpdate != nil ? [[@"last found pattern " stringByAppendingString: [DateFormatUtil getTimeElapsed:wctask.lastUpdate]] stringByAppendingString:@" ago."] : @"Not found";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (screenShot || [screenShot length] == 0) {
        self.imageView.image = [ImageUtil squareImageFromImage:[ImageUtil captureScreen:self.webPreview] scaledToSize:100];
        [self.imageView setContentMode:UIViewContentModeScaleToFill];
        [self.imageView setNeedsDisplay];
        [self.imageView reloadInputViews];
        [self saveImageToWCWebpage:url :self.imageView.image];
    }
}

-(void)saveImageToWCWebpage:(NSString *)url :(UIImage *)image{
    [[DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME] updateWithKey:url changes:@{@"image":UIImageJPEGRepresentation(image, 0.0)}];
}

-(NSData *)readImageFromWCWebpage:(NSString *)url {
    WCWebPage *wcp = (WCWebPage *)[[DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME] getByKey:url];
    if (wcp && wcp.image) {
        self.imageView.image = [UIImage imageWithData:wcp.image];
        [self.imageView setContentMode:UIViewContentModeScaleToFill];
        [self.imageView setNeedsDisplay];
        [self.imageView reloadInputViews];
//        [self.webPreview reload];
//        [self.imgView reloadInputViews];
    }
    return wcp.image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_title release];
    [_webPreview release];
    [_updateInfo release];
    [_imgView release];
    [super dealloc];
}
@end
