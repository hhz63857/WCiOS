//
//  BaseEntity.h
//  LocalTest
//
//  Created by Huahan on 4/20/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseEntity : NSManagedObject
@property (retain, nonatomic) NSString *key;
-(instancetype)initEntity:(NSString *)entityName key:(NSString *)keyVal;
@end
