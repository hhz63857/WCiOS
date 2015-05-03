//
//  FSTestSuit.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "FSTestSuit.h"
#import "LocalDataManager.h"
#import "SQLiteDataService.h"
#import "WCTask.h"

@implementation FSTestSuit
{
    NSString *documentName;
}

-(FSTestSuit *)init
{
    self = [super init];
    documentName = @"Done.sqlite";
    return self;
}

-(void) testSaveDirectly
{
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];
    WCTask *wt = [NSEntityDescription insertNewObjectForEntityForName:@"WCTask" inManagedObjectContext:[dm managedObjectContext]];
    wt.url = @"www.www.com";
    wt.lastUpdate = [[NSDate alloc] init];
    [dm saveRecord:wt];
}

-(void) startWithModel
{
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];
    NSManagedObject *player1 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"hhzaaa"];
    NSManagedObject *player2 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"hhzaaaz"];
    [dm saveRecord:player1];
    [dm saveRecord:player2];
    [dm readAll:@"Player"];
}

-(void) testUpdate
{
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];
    NSManagedObject *player1 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"cc"];
    NSManagedObject *player2 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"cc1"];
    [dm saveRecord:player1];
    [dm saveRecord:player2];
    [dm readAll:@"Player"];
    
    NSArray *parr = [dm get:@"Player" :@"name == %@" value:@"cc"] ;
    NSManagedObject *paa = [parr objectAtIndex:0];
    [paa setValue:@"caccc" forKey:@"name"];
    [dm saveRecord:paa];
    NSArray *a = [dm readAll:@"Player"];
    NSArray *pabb = [dm get:@"Player" :@"name == %@" value:@"caccc"] ;
}

-(void) testExePredication
{
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];
    NSManagedObject *player1 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"r1"];
    NSManagedObject *player2 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"r2"];
    [dm saveRecord:player1];
    [dm saveRecord:player2];
    NSArray * a = [dm exePredication:@"Player" predication:@"name = %@", @"r1"];
}

-(void) startTest
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSLog(@"%@", url);
    
    NSURL *nsurl = [url URLByAppendingPathComponent:documentName];
    UIManagedDocument *doc = [[UIManagedDocument alloc] initWithFileURL:nsurl];
    LocalDataManager *lm = [[LocalDataManager alloc] initWithDoc:doc url:nsurl];
    
    if([fileManager fileExistsAtPath:[nsurl path] ]) {
        NSLog(@"exist");
        [doc openWithCompletionHandler:^(BOOL isSuccess) {
            NSLog(@"exist => handler");
            [lm testOnDoc:doc];
        }];
    }
    else {
        NSLog(@"inexist");
        [doc saveToURL:nsurl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL isSuccess) {
            if(isSuccess) {
                NSLog(@"inexist => handler success");
                [lm testOnDoc:doc];
            } else {
                NSLog(@"inexist => handler failed");
            }
            NSLog(@"inexist => handler");
        }];
    }
    
    NSLog(@"end");
    while (YES) {
        NSDate *futureTime = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:futureTime];
    }
}

@end
