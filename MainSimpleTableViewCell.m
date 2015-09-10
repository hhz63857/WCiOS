//
//  MainSimpleTableViewCell.m
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainSimpleTableViewCell.h"
#import "WCTask.h"
#import "DateFormatUtil.h"
#import "NamingUtil.h"

@implementation MainSimpleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) initWithWCTask:(WCTask *)wctask
{
    if (wctask != nil && wctask.url != nil) {
        self.updateInfoField.text = wctask.lastUpdate != nil ? [[@"Last updated " stringByAppendingString: [DateFormatUtil getTimeElapsed:wctask.lastUpdate]] stringByAppendingString:@" ago."] : @"Not found";
        self.nicknameField.text = [NamingUtil getNickName:wctask];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_nicknameField release];
    [_updateInfoField release];
    [super dealloc];
}
@end
