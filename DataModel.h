//
//  LocalDataService.h
//  LocalTest
//
//  Created by Huahan on 4/19/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataEntryDelegate.h"
#import "SQLiteDataService.h"
#import "BaseEntity.h"

@interface DataModel : NSObject
+(NSMutableDictionary *) instanceDict;
+(instancetype) getSharedInstance:(NSString *)entityNameVal;
-(instancetype) initWithEntityName:(NSString *)entityNameVal;
-(id<DataEntryDelegate>) getByKey:(id)val;
-(NSArray *) getByField:(NSString *)fieldName fieldValue:(id)val;
-(NSArray *)readAll;
-(void) updateWithKey:(id)keyVal changes:(NSDictionary *)changes;
-(void) removeByKey:(id)val;
-(void)saveRecord:(BaseEntity *)record;
//-(NSString *)insertRecord:(BaseEntity *)record force:(BOOL)force;

@end
