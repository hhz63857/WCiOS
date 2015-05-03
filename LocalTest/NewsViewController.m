//
//  NewsViewController.m
//  LocalTest
//
//  Created by Huahan on 4/2/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "NewsViewController.h"
#import "AsyncNetworkDelegate.h"
#import "SQLiteDataService.h"
#import "News.h"

@implementation NewsViewController
{
    NSMutableArray *newsList;
    SQLiteDataService *dm;
    long hashTag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AsyncNetworkDelegate startAsyncDownloadDataToDB:@"https://newsdigest-yql.media.yahoo.com/v2/digest?date=2015-04-01"];
    dm = [SQLiteDataService sharedInstance];
    newsList = [[NSMutableArray alloc] init];
    hashTag = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell = [self makeLensListCell:CellIdentifier];
    }
    News *news = newsList[indexPath.row];
    
    UILabel *uuidLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:102];
    uuidLabel.text = news.uuid;
    titleLabel.text = news.title;
    
//    uuidLabelList[indexPath.row] = uuidLabel;
//    titleLabelList[indexPath.row] = titleLabel;
    
//    cell.textLabel.text = news.title;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (UITableViewCell *)makeLensListCell: (NSString *)identifier
{
    CGRect lbl1Frame = CGRectMake(8, 8, 300, 25);
    CGRect lbl2Frame = CGRectMake(8, 50, 300, 225);
    
    UILabel *lbl;
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    
    // Label with tag 1.
    lbl = [[UILabel alloc] initWithFrame:lbl1Frame];
    lbl.tag = 101;
    [cell.contentView addSubview:lbl];
    [lbl release];
    
    // Label with tag 2.
    lbl = [[UILabel alloc] initWithFrame:lbl2Frame];
    lbl.tag = 102;
    lbl.textColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lbl];
    [lbl release];
    
    // Add as many labels and other views as you like
    
    return cell;
}

-(void)loadData
{
    NSArray *arr = [dm readAll:@"News"];
    if (hashTag != [arr count]) {
        for (NSManagedObject *obj in arr) {
            NSString *title = [obj valueForKey:@"title"];
            NSString *uuid = [obj valueForKey:@"uuid"];
            News *news = [[News alloc] initWithTitle:title uuid:uuid];
            [newsList addObject:news];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
    [super viewWillAppear:animated];
}

@end
