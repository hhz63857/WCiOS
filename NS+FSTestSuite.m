//
//  NS+FSTestSuite.m
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NS+FSTestSuite.h"
#import "NetworkService.h"
#import "SQLiteDataService.h"
#import "NewsBuilder.h"

@implementation NS_FSTestSuite

+(void) downloadAndStore
{
    NSString *url = @"https://newsdigest-yql.media.yahoo.com/v2/digest?date=2015-04-01";
    NSURL *nsurl = [NSURL URLWithString:url];
    NSString *jsonString = [NetworkService performStoreRequestWithURL:nsurl];
    NSDictionary *dict = [NetworkService parseJSON:jsonString];
    
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];

    NSArray *arr = [NewsBuilder parse:dict];
    for (NSDictionary* dic in arr) {
        NSManagedObject *news1 = [dm createRecordWithEnitityName:@"News" Dict:
                                  dic];
    }
    
    [dm readAll:@"News"];
}

@end
