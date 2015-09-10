//
//  AlertUtil.h
//  LocalTest
//
//  Created by Huahan on 9/8/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertUtil : NSObject
+(void)showAlertWithTitle:(NSString *)title AndMsg:(NSString *)msg AndCancelButtonTitle:(NSString *)cancelButtonTitle;
@end
