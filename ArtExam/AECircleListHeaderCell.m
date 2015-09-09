//
//  AECircleListHeaderCell.m
//  ArtExam
//
//  Created by 2014－424 on 14-10-27.
//  Copyright (c) 2014年 2014－424. All rights reserved.
//

#import "AECircleListHeaderCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"

@interface AECircleListHeaderCell()
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UIImageView *iconImg;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLbl;

@end

@implementation AECircleListHeaderCell

- (void)awakeFromNib
{
    self.iconImg.layer.cornerRadius = 23.0;
    self.iconImg.layer.masksToBounds = YES;
    
    self.descriptionLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.descriptionLbl.numberOfLines = 2;

    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithCircle:(AECircle *)circle{
    self.nameLbl.text = circle.name;
    self.descriptionLbl.text = circle.mydescription;
    [self.descriptionLbl sizeToFit];
    if (circle.imgUrl) {
        [self.iconImg setImageWithURL:[NSURL URLWithString:circle.imgUrl] placeholderImage:nil];
    }
}

@end
