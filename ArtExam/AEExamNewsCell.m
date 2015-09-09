//
//  AEExamNewsCell.m
//  ArtExam
//
//  Created by liubo on 15/7/18.
//  Copyright (c) 2015年 liubo. All rights reserved.
//

#import "AEExamNewsCell.h"

@implementation AEExamNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithColleage:(AEExamNews *)examNews
{
    NSURL *imgUrl = [NSURL URLWithString:[[ROOTURL stringByAppendingString:IMGURL]stringByAppendingString:examNews.newsCover]];
    
    [self.cover setImageWithURL:imgUrl  placeholderImage:nil];
    
    self.title.text = examNews.newsTitle;
    self.views.text = [NSString stringWithFormat:@"阅读量 %@",examNews.newsViews];
    self.cdate.text = examNews.dateString;
//    self.cover.image = []
}

@end
