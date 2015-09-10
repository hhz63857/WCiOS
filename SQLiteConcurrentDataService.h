//
//  LocalDataModel.h
//  LocalTest
//
//  Created by Huahan Zhang on 4/1/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SQLiteDataService.h"

@interface SQLiteConcurrentDataService : SQLiteDataService
+(instancetype) getSharedInstance:(NSString *)entityNameVal;

//@property (strong, nonatomic) NSMutableDictionary *managedObjectContextDict;
//@property (strong, nonatomic) NSString *entityName;
//- (NSManagedObjectContext *)managedObjectContext;
@end
