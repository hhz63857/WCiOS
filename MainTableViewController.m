//
//  MainTableViewController.m
//  LocalTest
//
//  Created by Huahan on 4/15/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "LocalDataModel.h"
#import "WCDelegate.h"
#import "AsyncNetworkDelegate.h"
#define ENTITY_NAME @"WCTask"

@interface MainTableViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"will appear");
    [self loadDataFromDB];
    [self.tableView reloadData];
}

- (void)loadDataFromDB {
    LocalDataModel *dm = [[LocalDataModel alloc] init];
    self.WCTasks = [dm readAll:ENTITY_NAME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addTaskWithUrl:(NSString *)url Patterns:(NSString *)patterns Type:(NSInteger)type {
    LocalDataModel *dm = [[LocalDataModel alloc] init];
    NSManagedObject *task = [dm createRecordWithEnitityName:ENTITY_NAME Key:@"url" Value:url];
    [dm saveRecord:task];
}

-(void) refreshAllAsyn
{
    [self loadDataFromDB];
    for (WCTask *wct in self.WCTasks) {
        [AsyncNetworkDelegate startAsyncDownloadDataToDB:wct];
    }
}

#pragma mark - Table view data source
- (IBAction)add:(UIBarButtonItem *)sender {
    PageViewController *s = [[PageViewController alloc] init];
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:s  animated:YES completion:nil];
    
    UIWindow *window = [(WCDelegate *)[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = s;
    [window makeKeyAndVisible];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.WCTasks count];
}

- (MainTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellWithWebView"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    WCTask *wt = [self.WCTasks objectAtIndex:indexPath.row];
    [cell initWithWCTask:wt];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
