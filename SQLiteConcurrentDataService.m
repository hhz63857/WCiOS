//
//  LocalDataModel.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "SQLiteConcurrentDataService.h"
#import "Constant.h"

@implementation SQLiteConcurrentDataService

+(instancetype) getSharedInstance:(NSString *)entityNameVal{
    SQLiteConcurrentDataService *instance = [[self instanceDict] objectForKey:entityNameVal];
    if (!instance) {
        instance = [[self alloc] initWithEntityName:entityNameVal];
        [[self instanceDict] setObject:instance forKey:entityNameVal];
//        instance.entityName = entityNameVal;
    }
    return instance;
}

+(NSMutableDictionary *) instanceDict{
    static NSMutableDictionary *instanceDict = nil;
    if (instanceDict == nil) {
        instanceDict = [[NSMutableDictionary alloc] init];
    }
    return instanceDict;
}

-(instancetype) initWithEntityName:(NSString *)entityNameVal{
    self = [[SQLiteConcurrentDataService alloc] init];
    return self;
}


//- (NSManagedObjectContext *)managedObjectContext {
//    if (self.entityName) {
//        return [self managedObjectContextWithEntityName:self.entityName];
//    }
//    return nil;
//}
//
//- (NSManagedObjectContext *)managedObjectContextWithEntityName:(NSString *)entityName {
//    NSManagedObjectContext *mc = [_managedObjectContextDict objectForKey:entityName];
//    if (!mc) {
//        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//        if (coordinator) {
//            mc = [[NSManagedObjectContext alloc] init];
//            [mc setPersistentStoreCoordinator:coordinator];
//            [_managedObjectContextDict setObject:mc forKey:entityName];
//        }
//    }
//    return mc;
//}

@end
