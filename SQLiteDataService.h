//
//  LocalDataModel.h
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SQLiteDataService : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)sharedInstance;
-(NSManagedObject*)createRecordWithEnitityName:(NSString *)entityName Key:(NSString*)key Value:(NSString *)value;
-(NSManagedObject*)createRecordWithEnitityName:(NSString *)entityName Dict:(NSDictionary*)dict;
-(void)saveRecord:(NSManagedObject*)record;
-(NSArray*) readAll:(NSString *)entity;
-(NSArray *) get :(NSString *) entity : (NSString *) predicateFormat value: (NSString *) value;
- (NSArray *)exePredication:(NSString *)entity predication:(NSString *)predicateFormat, ...;
- (NSManagedObjectContext *)managedObjectContext;
@end
