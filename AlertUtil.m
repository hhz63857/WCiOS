//
//  AlertUtil.m
//  LocalTest
//
//  Created by Huahan on 9/8/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AlertUtil.h"

@implementation AlertUtil
+(void)showAlertWithTitle:(NSString *)title AndMsg:(NSString *)msg AndCancelButtonTitle:(NSString *)cancelButtonTitle{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
    return;

}
@end
