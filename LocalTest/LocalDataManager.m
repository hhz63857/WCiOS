//
//  LocalDataManager.m
//  LocalTest
//
//  Created by Huahan Zhang on 3/31/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "LocalDataManager.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Player+Item.h"

@implementation LocalDataManager{
    UIManagedDocument *doc;
    NSManagedObjectContext *context;
    NSURL *url;
}

-(LocalDataManager *) initWithDoc:(UIManagedDocument *)d url:(NSURL *)u
{
    self = [super init];
    doc = d;
    context = doc.managedObjectContext;
    url = u;
    return self;
}

-(void) testOnDoc:(NSString *)entity
{
    [self writeTestData:@"Player"];
    [self readAll:@"Player"];
}

-(void) writeTestData:(NSString *)entity
{
    id globalStore = [[context persistentStoreCoordinator] persistentStoreForURL:url];
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
    player.name = @"hh15";
    player.id = @(123222);
    
    [context assignObject:player toPersistentStore:globalStore];
    
    Player *player2 = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
    player2.name = @"hh332";
    player2.id = @(2222);
    [context assignObject:player2 toPersistentStore:globalStore];
}

-(void) readAll:(NSString *)entity
{
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:description];
    NSError *error;
    NSArray *arr = [context executeFetchRequest:req error:&error];
    NSLog(@"%d", [arr count]);
    NSLog(@"%@", arr);
}

//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    NSError *error = nil;
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//    NSPersistentStoreCoordinator* persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [Player]];
//    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error]);
//    
//    return persistentStoreCoordinator;
//}

@end
