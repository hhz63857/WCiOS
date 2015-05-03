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
#import "NetworkCallContext.h"
#import "BaseEntity.h"

@interface WCWebPage : BaseEntity<NetworkCallContext, DataEntryDelegate>
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * hashcode;
@property (nonatomic, retain) NSData *image;

-(instancetype)initWithUrl:(NSString *)url hashcode:(NSString *)hashcode;
-(void)setUrl:(NSString *)url;
@end
