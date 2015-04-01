//
//  Entity1.h
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity1 : NSManagedObject

@property (nonatomic, retain) NSNumber * attribute;
@property (nonatomic, retain) NSNumber * name;
@property (nonatomic, retain) NSSet *newRelationship;
@end

@interface Entity1 (CoreDataGeneratedAccessors)

- (void)addNewRelationshipObject:(NSManagedObject *)value;
- (void)removeNewRelationshipObject:(NSManagedObject *)value;
- (void)addNewRelationship:(NSSet *)values;
- (void)removeNewRelationship:(NSSet *)values;

@end
