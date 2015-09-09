//
//  AEStudioCell.m
//  test
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEStudioCell.h"
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"

@implementation AEStudioCell

- (void)awakeFromNib
{
    // Initialization code
    self.nameLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.detailsLbl.textColor = [DBNUtils getColor:@"999fab"];
    self.popularLbl.textColor = [DBNUtils getColor:@"999fab"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithStudio:(AEStudio *)studio{
    if ([studio.picArr count] > 0) {
        NSString *tmp = [[studio.picArr objectAtIndex:0] objectForKey:@"url"];
        if (tmp) {
            [self.imgView  setImageWithURL:[NSURL URLWithString:tmp] placeholderImage:nil];
        }
    }
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.nameLbl.text = studio.name;
    self.detailsLbl.text = studio.mydescription;
    self.popularLbl.text = [NSString stringWithFormat:@"人气值：%d",studio.popular];
}

@end
