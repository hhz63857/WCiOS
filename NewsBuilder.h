//
//  NewBuilder.h
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsBuilder : NSObject
+(NSDictionary *)parseFirst:(NSDictionary *)dict;
+(NSArray *)parse:(NSDictionary *)dict;
@end
