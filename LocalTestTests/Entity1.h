//
//  Entity1.h
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface Entity1 : NSManagedObject

@property (nonatomic) int32_t attribute;
@property (nonatomic) int32_t name;
@property (nonatomic, retain) NSSet *newRelationship;
@end

@interface Entity1 (CoreDataGeneratedAccessors)

- (void)addNewRelationshipObject:(Player *)value;
- (void)removeNewRelationshipObject:(Player *)value;
- (void)addNewRelationship:(NSSet *)values;
- (void)removeNewRelationship:(NSSet *)values;

@end
