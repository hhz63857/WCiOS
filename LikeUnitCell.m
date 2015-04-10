//
//  LikeUnitCell.m
//  LocalTest
//
//  Created by Huahan on 4/3/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "LikeUnitCell.h"

@interface LikeUnitCell ()
- (IBAction)likeButtonTapped:(UIButton *)sender;
- (IBAction)dislikeButtonTapped:(UIButton *)sender;
@end


@implementation LikeUnitCell{

}

- (void)awakeFromNib {
    // Initialization code
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (IBAction)likeButtonTapped:(id)sender
{
    [self.delegate didTapDisikeOnCell:self];
}

- (IBAction)dislikeButtonTapped:(id)sender {
    [self.delegate didTapDisikeOnCell:self];
}

-(void)setTopic:(NSString *)topic {
    self.label.text = topic;
}

+(NSString *)nibName{
    return @"LikeUnitCell";
}

+(NSString *)cellId{
    return @"LikeUnitCell";
}

+(NSInteger)cellHeight{
    return 52;
}

- (void) setCurrentFont:(UIFont *)currentFont
{
    self.label.font = currentFont;
}

@end
