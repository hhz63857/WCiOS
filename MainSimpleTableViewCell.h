//
//  MainSimpleTableViewCell.h
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCTask.h"

@interface MainSimpleTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *nicknameField;
@property (retain, nonatomic) IBOutlet UILabel *updateInfoField;
- (void) initWithWCTask:(WCTask *)wctask;
@end
