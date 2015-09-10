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
#import "AsyncSaveWCTask.h"
#import "MainTableViewCell.h"
#import "AlertUtil.h"
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

-(void)postCall:(id)data{
    NSMutableArray *ha = [RegexUtil regexGetFromString:data WithPattern:self.wctask.pattern];
    DataModel *wd = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    [wd updateWithKey:self.wctask.key changes:@{@"patternCount": @([ha count])}];
    [NSThread detachNewThreadSelector:@selector(searchPattern:) toTarget:self.wctask withObject:data];
}

-(id)getUId{
    return self.wctask.url;
}

-(id)getURL{
    return self.wctask.url;
}

@end


@interface WCTask(){
    MainTableViewCell *contextCell;
    NSString *cachedUrl;
}

@end

@implementation WCTask
@dynamic url;
@dynamic pattern;
@dynamic patternCount;
@dynamic nickname;
@dynamic type;
@dynamic lastUpdate;
//@dynamic contextCell;


-(instancetype)initWithUrl:(NSString *)url Pattern:(NSString *)pattern Type:(NSString *)type PatternCount:(NSInteger) patternCount Nickname:(NSString *)nickname
{
    if (!url || !pattern || !type) {
        return nil;
    }
    
    WCTask *wt = [super initEntity:@"WCTask" key:[url stringByAppendingPathComponent:pattern]];
    if (wt) {
        wt.url = url;
        wt.pattern = pattern;
        wt.type = type;
        wt.patternCount = patternCount;
        wt.lastUpdate = nil;
        wt.nickname = nickname;
        wt.key = [url stringByAppendingPathComponent:pattern];
        if (true || [type isEqualToString:PICKER_TITLE_SHOWS_MORE] || [type isEqualToString:PICKER_TITLE_SHOWS_LESS]) {
            __WCTaskNetworkContext *wcContext = [[__WCTaskNetworkContext alloc] initWithWCTask:wt];
            [AsyncNetworkDelegate startAsyncDownloadDataToDB:(id<NetworkCallContext> *)wcContext];
        }
        return wt;
    }
    else {
        [AlertUtil showAlertWithTitle:@"Already Exists" AndMsg:@"" AndCancelButtonTitle:@"OK"];
    }
    return nil;
}

-(void)setContextCell:(MainTableViewCell *)cell{
    contextCell = cell;
}

-(MainTableViewCell *)getContextCell{
    return contextCell;
}

-(void)searchPattern:(id)html
{
    if(!self.url) {
        NSLog(@"Skip for empty url");
        return;
    }
    NSLog(@"Searching %@ %@ %@", self.url, self.type, self.pattern);
    
    //1, do the regex match
    BOOL changed = [self isChanged:html];
    
    //2, update webtask & webpage
    DataModel *dm = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    
    NSDate *now = [[NSDate alloc] init];
    
    if (changed) {
        self.lastUpdate = now;
        
        if([self getContextCell]) {
            [[self getContextCell] updateLastUpdateLabel:self];
        }
        
        NSDictionary *dict = @{@"lastUpdate":now};
        [dm updateWithKey:self.key changes:dict];
        id v = [dm getByKey:self.key];
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

-(void)preInsertToDB{
    [AsyncNetworkDelegate uploadDataByHTTPGet:[[AsyncSaveWCTask alloc] initWithWCTask:self]];
}

-(void)preRemoveFromDB{
    [AsyncNetworkDelegate uploadDataByHTTPGet:[[AsyncSaveWCTask alloc] initWithWCTaskToDelete:self]];
    cachedUrl = [self.url copy];
}

-(void)postRemoveFromDB{
    if(cachedUrl) {
        static NSThread *_delThread = nil;
        _delThread = [[NSThread alloc] initWithTarget:self selector:@selector(deleteFromWCWebPage) object:NULL];
        [_delThread start];
//        [self performSelector:@selector(sleepThread) onThread:_delThread withObject:nil waitUntilDone:YES];

    }
}

-(void)sleepThread {
    NSLog(@"Suspend before try");
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"After sleep 3");
}

-(void)deleteFromWCWebPage{
    
    DataModel *wctaskDM = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    DataModel *wcwebpageDM = [DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME];
    NSArray *arr = [wctaskDM getByField:@"url" fieldValue:cachedUrl];
    if (arr == nil || [arr count] == 0) {
        [wcwebpageDM removeByKey:cachedUrl];
    }
}

@end
