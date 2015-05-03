//
//  LocalDataModel.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "SQLiteDataService.h"
#import "Constant.h"

@implementation SQLiteDataService

+(instancetype)sharedInstance{
    static SQLiteDataService *_sharedInstance;
    static dispatch_once_t m_token;
    dispatch_once(&m_token, ^{
        _sharedInstance = [[SQLiteDataService alloc] init];
    });
    return _sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:PLAYER_DOC_NAME];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

-(NSManagedObject*)createRecordWithEnitityName:(NSString *)entityName Key:(NSString*)key Value:(NSString *)value
{
    //Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    //Initialize Record
    NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    [record setValue:value forKey:key];
    return record;
}

-(NSManagedObject*)createRecordWithEnitityName:(NSString *)entityName Dict:(NSDictionary*)dict
{
    //Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    //Initialize Record
    NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    for(id key in dict) {
        [record setValue:[dict objectForKey:key] forKey:key];
    }
    return record;
}

-(NSManagedObject*)createRecordWithEnitityName:(NSString *)entityName Record:(NSManagedObject*)record
{
    //Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    //Initialize Record
    NSManagedObject *r = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    return r;
}

- (void)saveRecord:(NSManagedObject*)record{
    if (record != nil) {
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error]) {
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            NSLog(@"error !");
        }
        
    } else {
        NSLog(@"!error");
    }
}

-(NSArray*) readAll:(NSString *)entity
{
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:description];
    NSError *error;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:req error:&error];
    return arr;
}

-(NSArray *) get :(NSString *) entity : (NSString *) predicateFormat value: (NSString *) value{
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:description];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, value];
    [req setPredicate:predicate];
    NSError *error;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:req error:&error];
    return arr;
}

- (NSArray *)exePredication:(NSString *)entity predication:(NSString *)predicateFormat, ...
{
    va_list argumentList;
    va_start(argumentList, predicateFormat);
    
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat arguments: argumentList];
    [req setPredicate:predicate];
    NSError *error;
    NSArray *arr = [self.managedObjectContext executeFetchRequest:req error:&error];
    va_end(argumentList);
//    [arr release];
    return arr;
}

@end
