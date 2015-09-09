//
//  AECircleCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECircleCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"

@interface AECircleCell ()
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UIImageView *iconImg;

@end

@implementation AECircleCell

- (void)awakeFromNib
{
    // Initialization code
    self.iconImg.layer.cornerRadius = 23.0;
    self.iconImg.layer.masksToBounds = YES;
    
    self.iconImg.backgroundColor = [DBNUtils getColor:@"33CC66"];
}                                                                                                                                                                         

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithCircle:(AECircle *)circle{
    self.nameLbl.text = circle.name;
    if (circle.imgUrl) {
        [self.iconImg setImageWithURL:[NSURL URLWithString:circle.imgUrl] placeholderImage:nil];
    }
}

@end
