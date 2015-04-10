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
#import "Player.h"

@implementation LocalDataManager{
    UIManagedDocument *doc;
    NSManagedObjectContext *context;
    NSURL *url;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
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


- (NSString *)dataStorePath {
    return [[self documentsDirectory]
            stringByAppendingPathComponent:@"DataStore.sqlite"];
}

//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//    if (_persistentStoreCoordinator == nil) {
//        NSURL *storeURL = [NSURL fileURLWithPath:
//                                    [self dataStorePath]];
//        _persistentStoreCoordinator =
//            [[NSPersistentStoreCoordinator alloc]
//                initWithManagedObjectModel:self.managedObjectModel];
//        NSError *error;
//        if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                            configuration:nil
//                            URL:storeURL
//                            options:nil error:&error]) {
//            NSLog(@"Error %@ %@", error, [error userInfo]);
////            about();
//        }
//    }
//    return _persistentStoreCoordinator;
//}


-(void) writeTestData:(NSString *)entity
{
    id globalStore = [[context persistentStoreCoordinator] persistentStoreForURL:url];
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
    player.name = @"hh";
    
    [context assignObject:player toPersistentStore:globalStore];
    
    Player *player2 = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
    player2.name = @"hhk";
    [context assignObject:player2 toPersistentStore:globalStore];
}

-(void) readAll:(NSString *)entity
{
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:description];
    NSError *error;
    NSArray *arr = [context executeFetchRequest:req error:&error];
}

@end
