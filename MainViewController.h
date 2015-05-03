//
//  MainViewController.h
//  LocalTest
//
//  Created by Huahan on 4/21/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UINavigationItem *headLabel;
+(instancetype)sharedInstance;
-(void)scrollDownScrollView;
@end
