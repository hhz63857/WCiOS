//
//  WCTask.m
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCTask.h"
#import "LocalDataModel.h"
#import "Constant.h"
#import "RegexUtil.h"
#define ENTITY_NAME @"WCTask"

@implementation WCTask

-(void)saveData:(id)data
{
    //1, do the regex match
    self.changed = [self isChanged:data];
    
    //2,
    LocalDataModel *dm = [[LocalDataModel alloc] init];
    NSDictionary *dict = @{@"url" : self.url, @"type" : self.type, @"pattern" : self.pattern};
    NSManagedObject *task = [dm createRecordWithEnitityName:ENTITY_NAME Dict:dict];
    [dm saveRecord:task];
}

-(BOOL)isChanged:(NSString *)htmlString
{
    if ([self.type isEqualToString:PICKER_TITLE_SHOWS_UP]) {
        return [self doesShowUp:htmlString];
    } else if ([self.type isEqualToString:PICKER_TITLE_SHOWS_MORE]) {
        return [self doesShowMore:htmlString];
    } else if ([self.type isEqualToString:PICKER_TITLE_SHOWS_LESS]) {
        return [self doesShowLess:htmlString];
    } else if ([self.type isEqualToString:PICKER_TITLE_DISAPPEAR]) {
        return [self doesDisappear:htmlString];
    }
    return NO;
}

-(BOOL)doesShowUp:(NSString *)htmlString
{
    NSMutableArray *ha = [self regexGetFromString:htmlString WithPattern:self.pattern];
    return [ha count] > 0;
}

-(BOOL)doesShowMore:(NSString *)htmlString
{
    NSMutableArray *ha = [self regexGetFromString:htmlString WithPattern:self.pattern];
    return [ha count] > self.patternCount;
}

-(BOOL)doesShowLess:(NSString *)htmlString
{
    NSMutableArray *ha = [self regexGetFromString:htmlString WithPattern:self.pattern];
    return [ha count] < self.patternCount;
}

-(BOOL)doesDisappear:(NSString *)htmlString
{
    NSMutableArray *ha = [self regexGetFromString:htmlString WithPattern:self.pattern];
    return [ha count] == 0;
}

-(NSMutableArray *)regexGetFromString:(NSString *)source WithPattern:(NSString *)pattern {
    return [RegexUtil regexGetFromString:source WithPattern:pattern];
}

-(id)getUId
{
    return self.url;
}

-(id)getURL{
    return self.url;
}

@end

