//
//  MainTableViewController.m
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "MainSimpleTableViewCell.h"
#import "SQLiteDataService.h"
#import "WCDelegate.h"
#import "AsyncNetworkDelegate.h"
#import "Constant.h"
#import "DataModel.h"
#import "WCWebPage.h"
#import "WCTask.h"
#import "DateFormatUtil.h"
#import "BackgroundUtil.h"
#import "DetailWebViewController.h"
#import "JVFloatLabeledTextFieldViewController.h"
#import "MainViewController.h"

@interface MainTableViewController (){
    DataModel *wctaskDM;
    DataModel *wcwebpageDM;
    NSMutableArray *cellHeightArr;
    
}

@end

@implementation MainTableViewController

+(MainTableViewController *)sharedInstance{
    static MainTableViewController *_sharedInstance;
    static dispatch_once_t m_token;
    dispatch_once(&m_token, ^{
        _sharedInstance = [[MainTableViewController alloc] init];
    });
    return _sharedInstance;
}

-(instancetype) init{
    self = [super init];
    wctaskDM = [DataModel getSharedInstance:WCTASK_ENTITY_NAME];
    wcwebpageDM = [DataModel getSharedInstance:WCWEBPAGE_ENTITY_NAME];
    cellHeightArr = [[NSMutableArray alloc] init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainSimpleTableViewCell.h" bundle:nil] forCellReuseIdentifier:@"MainSimpleTableViewCell.h"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAllAsyn) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView.layer.borderWidth = 0;
    self.tableView.separatorColor = [UIColor clearColor];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadDataFromDB];
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row >= 0 && indexPath.row < [self.WCTasks count]) {
            WCTask *toRemoveWT = self.WCTasks[indexPath.row];
            NSString *url = [toRemoveWT.url copy];
            if (toRemoveWT != nil) {
                [wctaskDM removeByKey:toRemoveWT.key];
            }
            [self.WCTasks removeObjectAtIndex:indexPath.row];

            NSArray *arr = [wctaskDM getByField:@"url" fieldValue:url];
            if (arr == nil || [arr count] == 0) {
                [wcwebpageDM removeByKey:url];
            }
            
            [self.tableView reloadData];
        }
    }
}

- (void)loadDataFromDB
{
    //todo paging
    self.WCTasks = [NSMutableArray arrayWithArray: [wctaskDM readAll]];
    self.WCPages = [NSMutableArray arrayWithArray: [wcwebpageDM readAll]];
    int i = 0;
    for (WCTask *wc in self.WCTasks) {
        cellHeightArr[i] = [self showFullCellView:wc] ? @(115): @(44);
        i++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Exceed!!");
}

-(void) refreshAllAsyn
{
    [self loadDataFromDB];
    for (WCWebPage *wcw in self.WCPages) {
        [AsyncNetworkDelegate startAsyncDownloadDataToDB:wcw];
    }
    [self.tableView reloadData];
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
    }
    [[BackgroundUtil sharedInstance] randomSetBackImg];
    [MainViewController sharedInstance].view.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.WCTasks count];
}

-(BOOL) showFullCellView:(WCTask *)wt{
//    if (wt.lastUpdate == nil) {
//        return NO;
//    }
//    return [DateFormatUtil withinTimeElapse:wt.lastUpdate inSeconds:PATTERN_FIND_ALERT_TIME_INTERVAL];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCTask *wt = [self.WCTasks objectAtIndex:indexPath.row];
    if ([self showFullCellView:wt]) {
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellWithWebView"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell initWithWCTask:wt];
        return cell;
    } else {
        MainSimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainSimpleTableViewCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MainSimpleTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell initWithWCTask:wt];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [cellHeightArr[indexPath.row] floatValue];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WCTask *wt = self.WCTasks[indexPath.row];
    if (wt) {
        DetailWebViewController *detailViewController = [[DetailWebViewController alloc] initWithUrl:wt.url andPattern:wt.pattern];

        UIWindow *window = [(WCDelegate *)[[UIApplication sharedApplication] delegate] window];
        window.rootViewController = detailViewController;
        [window makeKeyAndVisible];
    }
}

- (void)dealloc {
    [super dealloc];
}
@end
