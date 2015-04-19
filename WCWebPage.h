//
//  WCWebPage.h
//  LocalTest
//
//  Created by Huahan on 4/18/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataEntryDelegate.h"


@interface WCWebPage : NSManagedObject<DataEntryDelegate>

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * html;
@property (nonatomic, retain) NSString * hashcode;

@end
