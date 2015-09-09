//
//  AESelectGradeCell.m
//  ArtExam
//
//  Created by dahai on 14-9-24.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AESelectGradeCell.h"

@implementation AESelectGradeCell

- (void)awakeFromNib
{
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

- (void)configureWithGradeInfo:(NSDictionary *)info{
    
    self.gradeLabel.text = [info objectForKey:@"name"];
}
@end
