//
//  BaseEntity.m
//  LocalTest
//
//  Created by Huahan on 4/20/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "BaseEntity.h"
#import "SQLiteDataService.h"
#import <CoreData/CoreData.h>
#import "DataModel.h"

@implementation BaseEntity
-(instancetype)initEntity:(NSString *)entityName key:(NSString *)keyVal
{
    SQLiteDataService *dm = [SQLiteDataService sharedInstance];
    NSString *format = @"key = %@";
    NSArray* arr = [dm exePredication:entityName predication:format, keyVal];
    if (arr != nil && [arr count] > 0) {
        return nil;
    }

    BaseEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[dm managedObjectContext]];
    return entity;
}

-(void)preSaveToDB{
    
}
-(void)postSaveToDB{
    
}

-(void)preInsertToDB{
    
}

-(void)postInsertToDB{
    NSLog(@"Not inherient. In Super method");
}

-(void)preUpdateToDB{
    
}

-(void)postUpdateToDB{
    
}

-(void)preRemoveFromDB{
    
}

-(void)postRemoveFromDB{
    
}

@end
