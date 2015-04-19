//
//  RegexUtil.h
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexUtil : NSObject
+(NSMutableArray *)regexGetFromString:(NSString *)source WithPattern:(NSString *)pattern;
@end
