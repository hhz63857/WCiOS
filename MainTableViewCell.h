//
//  MainTableViewCell.h
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCTask.h"

@interface MainTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIWebView *webPreview;
@property (retain, nonatomic) IBOutlet UILabel *updateInfo;
- (MainTableViewCell *)initWithIndexPath:(NSIndexPath *) indexPath;
- (void) initWithWCTask:(WCTask *)WCTask;
@end
