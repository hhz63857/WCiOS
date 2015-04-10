//
//  FSTestSuit.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "FSTestSuit.h"
#import "LocalDataManager.h"
#import "LocalDataModel.h"

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

-(void) startWithModel
{
    LocalDataModel *dm = [[LocalDataModel alloc] init];
    NSManagedObject *player1 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"hhz"];
    NSManagedObject *player2 = [dm createRecordWithEnitityName:@"Player" Key:@"name" Value:@"hhzz"];
    [dm saveRecord:player1];
    [dm saveRecord:player2];
    [dm readAll:@"Player"];
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
