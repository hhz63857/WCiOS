//
//  LikeUnitCell.h
//  LocalTest
//
//  Created by Huahan on 4/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LikeUnitCell;

@protocol LikeUnitCellDelegate <NSObject>
-(void)didTapLikeOnCell:(LikeUnitCell *)likeUnitCell;
-(void)didTapDisikeOnCell:(LikeUnitCell *)likeUnitCell;
@end

@interface LikeUnitCell : UICollectionViewCell

//TODO : Change type to weak
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIButton *like;
@property (nonatomic, strong) IBOutlet UIButton *dislike;
@property (nonatomic, strong) IBOutlet UIView *divideLine;
@property (nonatomic, strong) id<LikeUnitCellDelegate> delegate;

- (IBAction)likeButtonTapped:(UIButton *)sender;
-(void)setDelegate:(id<LikeUnitCellDelegate>)delegate;
-(void) config;
+(NSString *)nibName;
+(NSString *)cellId;
+(NSInteger )cellHeight;

@end
