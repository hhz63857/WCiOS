//
//  MainTableViewCell.m
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) initWithWCTask:(WCTask *)WCTask
{
    NSLog(@"load web %@", WCTask.url);
    if (WCTask != nil && WCTask.url != nil) {
        [self.webPreview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WCTask.url]]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_title release];
    [_webPreview release];
    [_updateInfo release];
    [super dealloc];
}
@end
