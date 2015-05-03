//
//  LocalDataService.m
//  LocalTest
//
//  Created by Huahan on 4/19/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "DataModel.h"
#import "BaseEntity.h"

@interface DataModel ()
{
    SQLiteDataService *ds;
    NSString *entityName;
    NSCache *persistableCache;
    NSMutableDictionary *allKeyIndex;
}
@end

@implementation DataModel

//todo
+(instancetype) getSharedInstance:(NSString *)entityNameVal{
    DataModel *instance = [[self instanceDict] objectForKey:entityNameVal];
    if (!instance) {
        instance = [[self alloc] initWithEntityName:entityNameVal];
        [[self instanceDict] setObject:instance forKey:entityNameVal];
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
    self = [super init];
    persistableCache = [[NSCache alloc] init];
    [persistableCache setTotalCostLimit:2000];
    ds = [SQLiteDataService sharedInstance];
    entityName = entityNameVal;
    allKeyIndex = [[NSMutableDictionary alloc] init];
    return self;
}

-(id<DataEntryDelegate>) getByKey:(id)val{
    id<DataEntryDelegate> persistableFound = nil;
    if (entityName) {
        NSString *key = [self generateCacheKeyWithEntityName:entityName fieldName:@"key" keyValue:val];
        persistableFound = [persistableCache objectForKey:key];
        if (!persistableFound) {
            NSString *format = @"key = %@";
            NSArray* arr = [ds exePredication:entityName predication:format, val];
            persistableFound = [arr count] > 0 ? [arr objectAtIndex:0] : nil;
            if (persistableFound) {
                [persistableCache setObject:persistableFound forKey:key];
            }
        }
    }
    return persistableFound;
}

-(NSString *)generateCacheKeyWithEntityName:(NSString *)entityN fieldName:(NSString *)field keyValue:(NSString *)keyVal{
    return [NSString stringWithFormat:@"%@:%@:%@", entityN, field, keyVal];
}

-(NSArray *) getByField:(NSString *)fieldName fieldValue:(id)val{
    NSArray *persistableFound = nil;
    if (entityName) {
        NSString *key = [self generateCacheKeyWithEntityName:entityName fieldName:fieldName keyValue:val];
        NSString *indexKey = [self generateCacheKeyWithEntityName:entityName fieldName:@"key" keyValue:val];
        persistableFound = [persistableCache objectForKey:key];
        if (!persistableFound) {
            NSString *format = [fieldName stringByAppendingString:@"= %@"];
            persistableFound = [ds exePredication:entityName predication:format, val];
            if (persistableFound) {
                [persistableCache setObject:persistableFound forKey:key];
                [self _addCacheKeyToIndex:indexKey :key];
            }
        }
    }
    return persistableFound;
}

-(void)_addCacheKeyToIndex:(NSString *)indexKey :(NSString *)cacheKey{
    NSMutableArray *arr = [allKeyIndex objectForKey:indexKey];
    if (!arr || !arr.count) {
        arr = [[NSMutableArray alloc] init];
        [allKeyIndex setObject:arr forKey:indexKey];
    }
    [[allKeyIndex objectForKey:indexKey] addObject:cacheKey];
}

-(NSArray *)readAll{
    NSArray *persistableFound = nil;
    NSString *key = [self generateCacheKeyWithEntityName:entityName fieldName:@"*" keyValue:@"*"];
    persistableFound = [persistableCache objectForKey:key];
//    NSLog(@"Read Found %@, %lu", key, (unsigned long)[persistableFound count]);
    if (!persistableFound) {
        persistableFound =[ds readAll:entityName];
        if (persistableFound) {
            [persistableCache setObject:persistableFound forKey:key];
        }
    }
    return persistableFound;
}

-(void)saveRecord:(BaseEntity *)record {
    [self _removeCacheKeys: [self generateCacheKeyWithEntityName:entityName fieldName:@"key" keyValue:record.key]];
    [ds saveRecord:record];
}

-(void)_removeCacheKeys:(NSString *)indexKey {
    if (indexKey) {
        NSMutableArray *keysGoingToRemove = [allKeyIndex objectForKey:indexKey];
        if (keysGoingToRemove && keysGoingToRemove.count > 0) {
            for (NSString *str in keysGoingToRemove) {
                [persistableCache removeObjectForKey:str];
            }
        }
        [allKeyIndex removeObjectForKey:indexKey];
        [persistableCache removeObjectForKey:indexKey];
        NSString *entireKey = [self generateCacheKeyWithEntityName:entityName fieldName:@"*" keyValue:@"*"];
        [persistableCache removeObjectForKey:entireKey];
//        NSLog(@"After remove %@, %lu", entireKey, (unsigned long)[[persistableCache objectForKey:entireKey] count]);
        NSArray *temp = [self readAll];
//        NSLog(@"temp1 %@ %lu", entireKey, [temp count]);
        temp = [self readAll];
//        NSLog(@"temp2 %@ %lu", entireKey, [temp count]);
    }
}

-(void) updateWithKey:(id)keyVal changes:(NSDictionary *)changes{
    NSObject<DataEntryDelegate> *record = [self getByKey:keyVal];
    for (id key in changes) {
        id val = [changes valueForKey:key];
        [record setValue:val forKey:key];
    }
    [self saveRecord:record];
}

-(void) removeByKey:(id)val{
    NSManagedObject *record = [self getByKey:val];
    [ds.managedObjectContext deleteObject:record];
    [self saveRecord:record];
}

@end
