//
//  WCTask.h
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkCallContext.h"
#import <CoreData/CoreData.h>
#import "DataEntryDelegate.h"

@interface WCTask : NSManagedObject<NetworkCallContext, DataEntryDelegate>
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *pattern;
@property (nonatomic) NSInteger patternCount;
@property (nonatomic) BOOL changed;
@end
