//
//  News.h
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uuid;
-(News *)initWithTitle:(NSString *)t uuid:(NSString*)u;
@end
