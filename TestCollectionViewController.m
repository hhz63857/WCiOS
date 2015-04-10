//
//  TestCollectionViewController.m
//  LocalTest
//
//  Created by Huahan on 4/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "LikeUnitCell.h"

@interface TestCollectionViewController ()

@end

@implementation TestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:[LikeUnitCell nibName] bundle:nil] forCellWithReuseIdentifier:[LikeUnitCell cellId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

-(void)didTapLikeOnCell:(LikeUnitCell *)likeUnitCell
{
    NSLog(@"In delegate like");
}

-(void)didTapDisikeOnCell:(LikeUnitCell *)likeUnitCell
{
    NSLog(@"In delegate dislike");
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LikeUnitCell *cell = (id)[collectionView dequeueReusableCellWithReuseIdentifier:[LikeUnitCell cellId] forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LikeUnitCell alloc] init];
    }
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([HRConfigurationManager sharedInstance].enableTopicDrillDown && [self.delegate respondsToSelector:@selector(newsTopicEntityViewControllerDidSelectNewsTopicEntity:)])  {
//        [self.delegate newsTopicEntityViewControllerDidSelectNewsTopicEntity:self.newsTopicEntityList[indexPath.item]];
//    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)dealloc {
    [super dealloc];
}
@end
