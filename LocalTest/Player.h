//
//  Player.h
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity1;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Entity1 *newRelationship;

@end
