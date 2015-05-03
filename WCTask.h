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
#import "BaseEntity.h"
#import <UIKit/UIKit.h>

@interface WCTask : BaseEntity<DataEntryDelegate>
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *pattern;
@property (nonatomic) NSInteger patternCount;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSDate *lastUpdate;
-(instancetype)initWithUrl:(NSString *)url Pattern:(NSString *)pattern Type:(NSString *)type PatternCount:(NSInteger) patternCount Nickname:(NSString *)nickname;
-(void)searchPattern:(id)html;
@end
