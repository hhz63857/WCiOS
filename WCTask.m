//
//  WCTask.m
//  LocalTest
//
//  Created by Huahan on 4/17/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "WCTask.h"
#import "SQLiteDataService.h"
#import "Constant.h"
#import "RegexUtil.h"
#import "DataModel.h"
#import "Constant.h"
#import "WCWebPage.h"
#import "DateFormatUtil.h"
#import "NetworkCallContext.h"
#import "AsyncNetworkDelegate.h"
#define ENTITY_NAME @"WCTask"

@interface __WCTaskNetworkContext:NSObject<NetworkCallContext>
@property(strong) WCTask *wctask;
-(instancetype)initWithWCTask:(WCTask *)wctask;
@end

@implementation __WCTaskNetworkContext

-(instancetype)initWithWCTask:(WCTask *)wctask{
    self = [super init];
    if (self && wctask) {
        self.wctask = wctask;
    }
    return self;
}

-(void)saveData:(id)data{
    NSMutableArray *ha = [RegexUtil regexGetFromString:data WithPattern:self.wctask.pattern];
    DataModel *wd = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    [wd updateWithKey:self.wctask.key changes:@{@"patternCount": @([ha count])}];
}

-(id)getUId{
    return self.wctask.url;
}

-(id)getURL{
    return self.wctask.url;
}

@end


@implementation WCTask
@dynamic url;
@dynamic pattern;
@dynamic patternCount;
@dynamic nickname;
@dynamic type;
@dynamic lastUpdate;

-(instancetype)initWithUrl:(NSString *)url Pattern:(NSString *)pattern Type:(NSString *)type PatternCount:(NSInteger) patternCount Nickname:(NSString *)nickname
{
    WCTask *wt = [super initEntity:@"WCTask" key:[url stringByAppendingPathComponent:pattern]];
    if (wt) {
        wt.url = url;
        wt.pattern = pattern;
        wt.type = type;
        wt.patternCount = patternCount;
        wt.lastUpdate = nil;
        wt.nickname = nickname;
        wt.key = [url stringByAppendingPathComponent:pattern];
        if ([type isEqualToString:PICKER_TITLE_SHOWS_MORE] || [type isEqualToString:PICKER_TITLE_SHOWS_LESS]) {
            __WCTaskNetworkContext *wcContext = [[__WCTaskNetworkContext alloc] initWithWCTask:wt];
            [AsyncNetworkDelegate startAsyncDownloadDataToDB:(id<NetworkCallContext> *)wcContext];
        }
        return wt;
    }
    else {
//        NSString *msg = [NSString stringWithFormat:@"Already exist entity url: %@ pattern: %@. ", url, pattern];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Already exist." message: @"" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    return nil;
}

-(void)searchPattern:(id)html
{
    //1, do the regex match
    BOOL changed = [self isChanged:html];
    
    //2, update webtask & webpage
    DataModel *dm = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    
    NSDate *now = [[NSDate alloc] init];
    
    if (changed) {
        NSDictionary *dict = @{@"lastUpdate":now};
        [dm updateWithKey:self.key changes:dict];
    }
    
    //3,todo send notification
    
    if (SHOW_PATTERN_FOUND_ALERT && changed && [DateFormatUtil withinTimeElapse:now inSeconds:PATTERN_FIND_ALERT_TIME_INTERVAL]) {
        //4, show alert
        NSString *msg = [self.pattern stringByAppendingPathComponent: @" shows up!"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Monitor Alert" message: msg delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
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
